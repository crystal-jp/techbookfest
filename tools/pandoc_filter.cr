require "json"

def walk(json, &block : Hash(String, JSON::Type) -> JSON::Type) : JSON::Type
  case json
  when Array(JSON::Type)
    json = json.flat_map do |j|
      k = walk(j, &block)
      if j.is_a?(Hash(String, JSON::Type)) && k.is_a?(Array(JSON::Type))
        k.as Array(JSON::Type)
      else
        [k]
      end
    end
  when Hash(String, JSON::Type)
    if c = json["c"]?
      json["c"] = walk c, &block
    end

    json = block.call json
  end

  json.as JSON::Type
end

def ast(t : String, c : JSON::Type)
  ({
    "t" => t,
    "c" => c,
  } of String => JSON::Type).as JSON::Type
end

json = JSON.parse_raw STDIN
json = walk(json) do |hash|
  next hash unless t = hash["t"]?.try &.as? String
  next hash unless t == "Link"
  next hash unless c = hash["c"]?.try &.as? Array(JSON::Type)
  next hash unless c1 = c[1].as? Array(JSON::Type)
  next hash unless c1.size == 1
  next hash unless str = c1[0].as?(Hash(String, JSON::Type))
  next hash unless str["t"].as?(String) == "Str"
  next hash unless url1 = str["c"].as?(String)
  next hash unless url2 = c[2].as?(Array(JSON::Type)).try &.[0].as?(String)
  next hash if url1 == url2

  c1.push(ast("Note", [ast("Para", [ast("Link", [c[0], [ast("Str", url2)] of JSON::Type, c[2]] of JSON::Type)])]))
  c1
end

json.to_json STDOUT
