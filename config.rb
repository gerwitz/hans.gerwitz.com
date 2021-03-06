set :css_dir, "assets/stylesheets"
# set :fonts_dir, "assets/fonts"
set :images_dir, "assets/images"
set :js_dir, "assets/javascripts"

# set :relative_links, true

set :markdown_engine, :redcarpet
set :markdown,
  no_intra_emphasis: true,
  fenced_code_blocks: true,
  tables: true,
  autolink: true,
  smartypants: true,
  space_after_headers: true,
  footnotes: true

# Methods defined in the helpers block are available in templates
helpers do
  def nav_link(link_text, url, options = {})
    options[:class] ||= ""
    current_url = current_resource.url
    if current_url.end_with?('index.html')
      current_url = File.dirname(current_url)
    end
    if current_resource.url == url
      return "<span class=""current top"">#{link_text}</span>"
    elsif current_resource.url.start_with?(url)
      options[:class] << " current"
      return link_to(link_text, url, options)
    else
      return link_to(link_text, url, options)
    end
  end

  def list_pages(pages)
    output = "<ul>"
    pages.each do |p|
      output << "<li>"
      output << "<div>#{link_to(p.data.title, p.url)}</div>"
      output << "<div>#{p.data.subtitle}</div>" if p.data.subtitle
      output << "</li>"
    end
    output << "</ul>"
  end

  def quote_for_tags(tags)
    q = data.quotes.select{|q| q.tags && (tags - q.tags) == []}.sample
    partial 'library/quotes/quote', object: q
  end
end

activate :blog do |blog|
  blog.name = "writing"
  blog.prefix = ""
  blog.sources = "/writing/{year}/{month}-{day}-{title}.html" # if this changes, adjust search below
  blog.default_extension = ".md"
  blog.summary_separator = /READMORE/
  blog.summary_length = 250

  blog.layout = "writing"

  blog.calendar_template = "writing/calendar_template.html"

  blog.permalink = "/{year}/{month}/{day}/{title}.html"
  blog.year_link = "/{year}/index.html"
  blog.month_link = "/{year}/{month}/index.html"
  blog.day_link = "/{year}/{month}/{day}/index.html"

  blog.custom_collections = {
    categories: {
      link: '/writing/{categories}.html',
      template: 'writing/category_template.html'
    }
  }
end

activate :blog do |blog|
  blog.name = "notes"
  blog.prefix = ""
  blog.sources = "/notes/{year}/{month}/{day}-{slug}.html" # if this changes, adjust search below
  blog.default_extension = ".md"

  blog.paginate = true

  blog.layout = "note"

  # blog.calendar_template = "writing/calendar_template.html"

  blog.permalink = "/{year}/{month}/{day}/{slug}.html"
  # blog.year_link = "/{year}/index.html"
  # blog.month_link = "/{year}/{month}/index.html"
  # blog.day_link = "/{year}/{month}/{day}/index.html"
end

# page "/*/*", layout: :page
# page "/feed/*", layout: false
# page "/writing/*", layout: :page

page "/about/*", layout: :page
page "/library/*", layout: :page
page "/history/*", layout: :page
page "/projects/*", layout: :page
page "/site/*", layout: :page

activate :search do |search|
  search.resources = ['writing/', 'notes/', 'library/', 'projects/', 'site/', 'about/']
  search.index_path = 'search.json'
  search.fields = {
    title:   {boost: 100, store: true, required: true},
    path:    {index: false, store: true},
    tags:    {boost: 100},
    content: {boost: 50},
    url:     {index: false, store: true}
  }
  search.before_index = Proc.new do |to_index, to_store, resource|
    path = resource.path
# puts("Indexing #{path}")
    to_store[:path] = path
    path_split = path.split('/',2)
    section = path_split.first
    to_store[:section] = section
    if section == 'writing'
      throw(:skip) unless resource.is_a?( ::Middleman::Blog::BlogArticle )
      to_store[:date] = resource.date.iso8601
    end
  end
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
