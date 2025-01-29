module ApplicationHelper
  LINKS = [
    { name: "Miembros", path: "/miembros", modules: [ "members" ] },
    { name: "Ofrendas", path: "/ofrendas", modules: [ "offerings" ] },
    { name: "Diezmos", path: "/diezmos", modules: [ "tithes" ] },
    # { name: "Talentos", path: "/talentos", modules: [ "talents" ] },
    # { name: "Compradores", path: "/compradores", modules: [ "talent_buyers" ] }
  ]

  def nav_bar_links
    html = ""

    Current.user.modules.each do |module_name|
      LINKS.each do |link|
        if link[:modules].include?(module_name)
          html << nav_bar_link(link)
        end
      end
    end

    html.html_safe
  end

  private
  def nav_bar_link(link)
    link_to link[:name], link[:path], class: "block md:inline-block rounded-md px-3 py-4 font-medium text-gray-300 hover:bg-gray-700 hover:text-white", data: { navbar_target: "link" }
  end
end
