require 'nokogiri'

dictionary_doc = File.open("../../JMdict_e/JMdict_e" ) {|f| Nokogiri::XML(f)}
entries = dictionary_doc.xpath("//entry")

i = 0

entries.each do |entry|

    # if entry.xpath('keb')
    #     puts entry.xpath('keb')
    # else
    #     puts entry.rpath('reb')
    # end

    if !entry.xpath('k_ele/keb').empty?
        entry.xpath('k_ele/keb').each {|node| puts node.content}
    else
        entry.xpath('r_ele/reb').each {|node| puts node.content}
    end

    # puts entry.elements.to_a

end
