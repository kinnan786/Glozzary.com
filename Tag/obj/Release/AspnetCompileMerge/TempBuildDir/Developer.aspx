<%@ Page Language="C#" MasterPageFile="~/MasterPages/General.Master" AutoEventWireup="true" CodeBehind="Developer.aspx.cs" Inherits="Tag.Developer" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <style type="text/css">
        pre {
            background-color: #f1f1f1;
            border: 1px solid #e3e3e3;
            border-radius: 3px;
            font-size: 12px;
            overflow-x: scroll;
            padding: 12px 10px;
        }

        h3.apply { font-size: 20px; }

        .preview h3 {
            color: #333;
            font-family: "Adelle-Bold", serif;
            font-size: 30px;
        }

        h3 {
            color: #666;
            font-family: "Adelle-Light", sans-serif;
            font-size: 20px;
            font-weight: normal;
            line-height: 27px;
            margin-left: 0;
        }

        .steps { font-size: 15px; }

        .tableclassed table { width: 100%; }

        .tableclassed table th {
            border: 1px solid #e3e3e3;
            font-family: "Adelle-Bold", sans-serif;
            padding: 12px 15px;
            text-align: left;
        }

        .tableclassed table th.field { width: 80px; }

        .tableclassed table th.desc { width: 500px; }

        .tableclassed table th.required { width: 20px; }

        .tableclassed table td:first-child { width: 80px; }

        .tableclassed table td {
            border: 1px solid #e3e3e3;
            font-family: "Adelle-Light", sans-serif;
            font-size: 14px;
            padding: 12px 15px;
            vertical-align: top;
            width: 250px;
            word-wrap: break-word;
        }

        * {
            font-family: "Adelle-Regular", sans-serif;
            font-size: 12px;
        }

        .section h3 {
            color: #666;
            font-family: "Adelle", sans-serif;
            font-weight: bold;
        }

        h3 {
            color: #666;
            font-family: "Adelle-Light", sans-serif;
            font-size: 20px;
            font-weight: normal;
            line-height: 27px;
            margin-left: 0;
        }
    </style>
    <div style="color: black; font-size: x-large; font-weight: bold; text-align: center;">
        Open Graph MetaTags
    </div>
    <hr />
    <div class="roundborder1" style="text-align: left;">
        Make your product, recipe, movie, article or place content more useful.
        How to
        <ol>
            <li>Decide what kind of content (product, recipe, movie, article or place) your website has    </li>
            <li>Read the documentation below</li>
            <li>Add the appropriate metatags to your site</li>
        </ol>
        <h3 id="semanticType">Semantic Markup</h3>
        <hr />
        <br />
        <h3 class="apply">1. Product</h3>
        <div style="padding-left: 20px;">
            Basic format for single product pages If your product pages contain only one product, you can use this format.
            <br />
            <br />
            <h3>Open Graph tags</h3>
            <div class="divclassed">
                This method uses the Open Graph standard developed by Facebook. You include information about your products in the HTML header of the product page. For example: <a href="http://shop.famsf.org/do/product/BK5160">shop.famsf.org/do/product/BK5160</a> would include the following in the HTML header:
            </div>
            <pre style="width: 100%;">
&lt;head&gt;
    &lt;meta property="og:title" content="de Young Copper Bookmark" /&gt;
    &lt;meta property="og:description" content="Our signature bookmark derived from the de Young's unique architecture and copper exterior. Measures 5 3/4'' x 1 1/4''. FAMSF Exclusive." /&gt;
    &lt;meta property="og:type" content="product" /&gt;
    &lt;meta property="og:url" content="http://shop.famsf.org/do/product/BK5160" /&gt;
    &lt;meta property="og:image" content="http://shop.famsf.org/storeImages/images/store/BK5160.jpg" /&gt;
    &lt;meta property="og:site_name" content="FAMSFStore.com" /&gt;
    &lt;meta property="og:price:amount" content="15.00" /&gt;
    &lt;meta property="og:price:currency" content="USD" /&gt;
    &lt;meta property="og:availability" content="instock" /&gt;
    &lt;meta property="og:rating" content="4.5" /&gt;
    &lt;meta property="og:gender" content="unisex" &gt;
    &lt;meta property="og:Keywords" content="Cooper, Bookmark,Tag1,Tag2" &gt;
    &lt;meta property="og:Emotion" content="Love,Like,Have,Beautiful" &gt;
&lt;/head&gt;
</pre>
            <div>
                If you already use Open Graph tags in your product pages, adding product info should be straightforward. On the downside, this format doesn't support multiple products descriptions in one page. Learn more at http://ogp.me/ns/product and http://ogp.me/.
            </div>
            <br />
            <h3>Supported fields:</h3>
            <div class="tableclassed">
                <table>
                    <tbody>
                        <tr>
                            <th class="field">Field</th>
                            <th class="desc">Description</th>
                            <th class="required">Required?</th>
                        </tr>
                        <tr>
                            <td>og:type</td>
                            <td>Must be "product"</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:title</td>
                            <td>Product name, may be truncated, all formatting and HTML tags will be removed.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:price:amount
                            </td>
                            <td>Product price (without currency sign, for example "6.50").</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:price:currency
                            </td>
                            <td>Currency code string as defined in http://www.xe.com/iso4217.php (for example "USD").</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:site_name</td>
                            <td>Store name (for example "Etsy.com");specifying this field is strongly suggested.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:image</td>
                            <td>URL for a high resolution image for the product.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:description</td>
                            <td>Product description, may be truncated, all line breaks and HTML tags will be removed.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:price:start_date
                            </td>
                            <td>Start time of the sale in <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO 8601 date format</a>.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:price:end_date
                            </td>
                            <td>End time of the sale in <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO 8601 date format</a>.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:brand</td>
                            <td>Brand name (for example "Lucky Brand")</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:availability
                            </td>
                            <td>Case insensitive string, possible values: "in stock" (or "instock"), "preorder", "backorder"
                                (or "pending"; will be back in stock soon), "out of stock" (or "oos"; may be back in stock
                                some time), "discontinued". Discontinued items won't be part of a daily scrape and marking
                                them as such will decrease the load on your servers.
                            </td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:availability:destinations
                            </td>
                            <td>ISO 3166-1 alpha-2 country code representing a country the product can be shipped to. If available anywhere in the world, use "All". Multiple countries can be provided.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:gender</td>
                            <td>Gender property of this product can only be 'male', 'female' and 'unisex'.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:rating</td>
                            <td>Aggregate rating for the item (e.g. 4.5).</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:Keyword or Keyword</td>
                            <td>Contains all the tags/ Keywords seperated by comma, maximum 30 tags allowed these will be automatically converted to tags</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:Emotion</td>
                            <td>Contains all the Emotions seperated by comma, maximum 30 Emotions allowed these will be automatically converted to Emotion Tags</td>
                            <td>Y</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <h3 class="apply">2. Recipe</h3>
        <div style="padding-left: 20px;">
            This method uses the Open Graph standard developed by Facebook. You include information about your Recipe in the HTML header of the product page.
            For example: <a href="http://allrecipes.com/Recipe/Vegetarian-Korma/Detail.aspx?soid=carousel_0_rotd&prop24=rotd">http://allrecipes.com/Recipe/Vegetarian-Korma/Detail.aspx?soid=carousel_0_rotd&prop24=rotd</a> would include the following in the HTML header:
            <br />
            <br />
            <h3 class="apply">Open Graph tags</h3>
            This method uses the Open Graph standard developed by Facebook. You include information about your Receipe in the HTML header of the Receipe page. For example: <a href="http://allrecipes.com/Recipe/Vegetarian-Korma/Detail.aspx?soid=carousel_0_rotd&prop24=rotd">http://allrecipes.com/Recipe/Vegetarian-Korma/Detail.aspx?soid=carousel_0_rotd&prop24=rotd</a> would include the following in the HTML header:
            <pre style="width: 100%;">&lt;head&gt;
        &lt;meta property="og:name" content="Vegetarian Korma" /&gt;
        &lt;meta property="og:ingredients" content="1 1/2 tablespoons vegetable oil, 1 small onion diced,1 teaspoon minced fresh ginger root,4 cloves garlic, minced 2 potatoes,
            cubed 4 carrots,cubed 1 fresh jalapeno pepper, seeded and sliced,3 tablespoons ground unsalted cashews" /&gt;
        &lt;meta property="og:type" content="recipe" /&gt;
        &lt;meta property="og:url" content="http://allrecipes.com/Recipe/Vegetarian-Korma/Detail.aspx?soid=carousel_0_rotd&prop24=rotd" /&gt;
        &lt;meta property="og:image" content="http://images.media-allrecipes.com/userphotos/250x250/00/11/64/116474.jpg" /&gt;
        &lt;meta property="og:site_name" content="allrecipes.com" /&gt;
        &lt;meta property="og:cookTime" content="30" /&gt;
        &lt;meta property="og:prepTime" content="25" /&gt;
        &lt;meta property="og:totalTime" content="55" /&gt;
        &lt;meta property="og:recipeYield" content="4" /&gt;
        &lt;meta property="og:description" content="Delicious. Korma usually doesn&#39;t have cream or tomato sauce in it.Try coconut milk instead. Better if you use garam masala,
        turmeric and cardamon instead of prepared curry powder.This is good for those who eat chicken. Just add some cooked cubes of it to the recipe.
        Use yukon gold potatoes cut in a dice, and they will get done in the alloted time. A great meal for families or for guests." /&gt;
        &lt;meta property="og:aggregateRating" content="5" &gt;
        &lt;meta property="og:Keywords" content="Indian Cusine, Vegetarian,Vegetarian Korma" &gt;
        &lt;meta property="og:Emotion" content="Love,Like,Yummy,Delicious" &gt;
        &lt;/head&gt;
</pre>
            <br />
            <h3>Supported fields:</h3>
            <div class="tableclassed">
                <table>
                    <tbody>
                        <tr>
                            <th class="field">Field</th>
                            <th class="desc">Description</th>
                            <th class="required">Required?</th>
                        </tr>
                        <tr>
                            <td>og:name</td>
                            <td>Title of the recipe. All formatting and HTML tags will be removed. Long titles may be
                                truncated for display purposes.
                            </td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:ingredients</td>
                            <td>Ingredients used the recipe. Annotate each individual ingredient separately.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:url</td>
                            <td>Canonical URL for the page, e.g. "http://allrecipes.com/recipe/simple-white-cake/"
                                (The canonical URL may also be specified with standard HTML head tags:
                                &lt;link rel="canonical" href="..."/&gt;)
                            </td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:image</td>
                            <td>URL for a high resolution image for the recipe.
                            </td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:cookTime</td>
                            <td>Time it takes to cook the recipe, in ISO 8601 duration format.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:prepTime</td>
                            <td>Time it takes to prepare the recipe, in ISO 8601 duration format.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:totalTime</td>
                            <td>Total time it takes to cook and prepare the recipe, in ISO 8601 duration format.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:recipeYield</td>
                            <td>Quantity yielded or servings made by this recipe, e.g. "5 servings" or "Serves 4-6" or "Yields 10 burgers".</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:description</td>
                            <td>Recipe description. This field is not displayed but may be indexed for search
                                purposes.
                            </td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:aggregateRating</td>
                            <td>Recipe ratings as defined in <a href="http://schema.org/AggregateRating">http://schema.org/AggregateRating</a>.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:Keyword or Keyword</td>
                            <td>Contains all the tags/ Keywords seperated by comma, maximum 30 tags allowed these will be automatically converted to tags</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:Emotion</td>
                            <td>Contains all the Emotions seperated by comma, maximum 30 Emotions allowed these will be automatically converted to Emotion Tags</td>
                            <td>Y</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <br />
        <h3 class="apply">3. Movie</h3>
        <div style="padding-left: 20px">
            Basic format for Movie pages If your Movie pages contain only one Movie, you can use this format.
            <br />
            <br />
            <h3 class="apply">Open Graph tags</h3>
            <div class="divclassed">
                This method uses the Open Graph standard developed by Facebook. You include information about your Movie in the HTML header of the Movie page. For example: <a href="http://www.imdb.com/title/tt0119008/?ref_=hm_rec_tt">http://www.imdb.com/title/tt0119008/?ref_=hm_rec_tt</a> would include the following in the HTML header:
            </div>
            <pre style="width: 100%;">&lt;head&gt;
    &lt;meta property="og:name" content="Donnie Brasco (1997)" /&gt;
    &lt;meta property="og:description" content="Directed by Mike Newell.With Al Pacino, Johnny Depp, Michael Madsen, Bruno Kirby.
    An FBI undercover agent infilitrates the mob and finds himself identifying more with the mafia life to the expense of his regular one." /&gt;
    &lt;meta property="og:type" content="Movie" /&gt;
    &lt;meta property="og:url" content="http://www.imdb.com/title/tt0119008/?ref_=hm_rec_tt" /&gt;
    &lt;meta property="og:image"
    content="http://ia.media-imdb.com/images/M/MV5BNjYwMTI0NzUzOV5BMl5BanBnXkFtZTgwNjk3NjQxMTE@._V1_SY500_SX338_AL_.jpg" /&gt;
    &lt;meta property="og:site_name" content="imdb.com" /&gt;
    &lt;meta property="og:actor" content="Al Pacino, Johnny Depp, Michael Madsen, Bruno Kirby" /&gt;
    &lt;meta property="og:director" content="Mike Newell" /&gt;
    &lt;meta property="og:genre" content="Biography" /&gt;
    &lt;meta property="og:duration" content="90" /&gt;
    &lt;meta property="og:datePublished" content="1997" /&gt;
    &lt;meta property="og:aggregateRating" content="5" &gt;
    &lt;meta property="og:contentRating" content="5" &gt;
    &lt;meta property="og:Keywords" content="Movies, Biography,Crime,Jonny Depp,Al Pacino" &gt;
    &lt;meta property="og:Emotion" content="Love,Like,Watched,Informative" &gt;
&lt;/head&gt;
</pre>
            <br />
            <h3>Supported fields:</h3>
            <<div class="tableclassed">
                 <table>
                     <tbody>
                         <tr>
                             <th class="field">Field</th>
                             <th class="desc">Description</th>
                             <th class="required">Required?</th>
                         </tr>
                         <tr>
                             <td>og:url</td>
                             <td>Canonical URL for the page, for example "http://mymoviesite.com/taxidriver_1976.html"
                             </td>
                             <td>Y</td>
                         </tr>
                         <tr>
                             <td>og:name</td>
                             <td>Movie title, may be truncated, all formatting and HTML tags will be removed.</td>
                             <td>Y</td>
                         </tr>
                         <tr>
                             <td>og:description</td>
                             <td>Movie description, may be truncated, all formatting and HTML tags will be removed.</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:image</td>
                             <td>URL for a high resolution image for the movie. </td>
                             <td>Y</td>
                         </tr>
                         <tr>
                             <td>og:duration</td>
                             <td>Duration of the movie, in ISO 8601 duration format.</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:genre</td>
                             <td>Genre of the movie.</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:actor</td>
                             <td>Cast member of the movie as defined in <a href="http://schema.org/Person">http://schema.org/AggregateRating</a> (annotate each person separately).</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:director</td>
                             <td>Director of the movie as defined in <a href="http://schema.org/Person">http://schema.org/AggregateRating</a> (annotate each person separately).</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:contentRating</td>
                             <td>Content rating (For example "PG-13").</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:datePublished</td>
                             <td>Movie release date in in ISO 8601 date format.</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:aggregateRating</td>
                             <td>Movie ratings as defined in <a href="http://schema.org/AggregateRating">http://schema.org/AggregateRating</a>.</td>
                             <td>N</td>
                         </tr>
                         <tr>
                             <td>og:Keyword or Keyword</td>
                             <td>Contains all the tags/ Keywords seperated by comma, maximum 30 tags allowed these will be automatically converted to tags</td>
                             <td>Y</td>
                         </tr>
                         <tr>
                             <td>og:Emotion</td>
                             <td>Contains all the Emotions seperated by comma, maximum 30 Emotions allowed these will be automatically converted to Emotion Tags</td>
                             <td>Y</td>
                         </tr>
                     </tbody>
                 </table>
             </div>
        </div>
        <br />
        <br />
        <h3 class="apply">4. Article</h3>
        <div style="padding-left: 20px">
            Basic format for Article, you can use this format.
            <br />
            <br />
            <h3 class="apply">Open Graph tags</h3>
            This method uses the Open Graph article type. You include information about your article in the HTML header of the article page. Here's an example:
            <pre style="width: 100%;">&lt;head&gt;
        &lt;meta property="og:title" content="Top 10 national parks in California" /&gt;
        &lt;meta property="og:description" content="Yosemite, Death Valley, Joshua Tree, Redwood California's national and state parks are home to some of the
            most iconic views and landscapes on the planet" /&gt;
        &lt;meta property="og:type" content="article" /&gt;
        &lt;meta property="og:url" content="http://www.theguardian.com/travel/2013/sep/17/top-10-national-parks-california" /&gt;
        &lt;meta property="og:site_name" content="TheGuardian.com" /&gt;
        &lt;meta property="og:image" content="http://static.guim.co.uk/sys-images/Travel/Pix/gallery/2013/9/16/1379354751315/Death-Valley-Calif.-001.jpg" /&gt;
        &lt;meta property="og:published_time" content="2013-09-17T05:59:00+01:00" /&gt;
        &lt;meta property="og:section" content="Travel" /&gt;
        &lt;meta property="og:Keywords" content="California, Travel,United States,South America" &gt;
        &lt;meta property="og:Emotion" content="Love,Like,Informative,Funny" &gt;
        &lt;/head&gt;
</pre>
            <br />
            <h3>Supported fields:</h3>
            <div class="tableclassed">
                <table>
                    <tbody>
                        <tr>
                            <th class="field">Field</th>
                            <th class="desc">Description</th>
                            <th class="required">Required?</th>
                        </tr>
                        <tr>
                            <td>og:type</td>
                            <td>Must be "article" or "blog"</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:title</td>
                            <td>Article title, may be truncated, all formatting and HTML tags will be removed.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:site_name</td>
                            <td>Site name (for example "TheGuardian.com");specifying this field is strongly suggested.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:url</td>
                            <td>Canonical URL for the page, for example"http://www.theguardian.com/travel/2013/sep/17/top-10-national-parks-california"
                            </td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:description</td>
                            <td>Article description or summary, may be truncated, all line breaks and HTML tags will be removed.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:image</td>
                            <td>URL for a high resolution image for the article.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:published_time</td>
                            <td>Article publish time in <a href="http://en.wikipedia.org/wiki/ISO_8601">ISO 8601 date format</a>.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:author</td>
                            <td>Article author, all line breaks and HTML tags will be removed.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:section</td>
                            <td>Article section name, all line breaks and HTML tags will be removed.</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:Keyword or Keyword</td>
                            <td>Contains all the tags/ Keywords seperated by comma, maximum 30 tags allowed these will be automatically converted to tags</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:Emotion</td>
                            <td>Contains all the Emotions seperated by comma, maximum 30 Emotions allowed these will be automatically converted to Emotion Tags</td>
                            <td>Y</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <br />
        <br />
        <h3 class="apply">5. Place</h3>
        <div style="padding-left: 20px">
            We support Open Graph Place formats.
            <br />
            <br />
            <h3 class="apply">Open Graph tags</h3>
            <div>
                This method uses the Open Graph standard developed by Facebook. You include information about your place in the HTML header of the place page. Here's an example:
            </div>
            <pre style="width: 100%;">&lt;head&gt;
&lt;meta property="og:title" content="Civic Center/UN Plaza BART Station" /&gt;
&lt;meta property="og:description" content="Subway in San Francisco, CA"/&gt;
&lt;meta property="og:url" content="https://foursquare.com/v/civic-centerun-plaza-bart-station/4813bc50f964a520414f1fe3" /&gt;
&lt;meta property="og:type" content="place" /&gt;
&lt;meta property="og:site_name" content="Foursquare.com" /&gt;
&lt;meta property="og:Keywords" content="Subway, San Francisco,Civic Center,UN Plaza, BART Station" &gt;
&lt;meta property="og:Emotion" content="Love,Like,Visited,Beautiful" &gt;
&lt;/head&gt;
</pre>
            <br />
            <h3>Supported fields:</h3>
            <div class="tableclassed">
                <table>
                    <tbody>
                        <tr>
                            <th class="field">Field</th>
                            <th class="desc">Description</th>
                            <th class="required">Required?</th>
                        </tr>
                        <tr>
                            <td>og:type</td>
                            <td>Must be "place"</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:title</td>
                            <td>Place Name</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:description</td>
                            <td>Place Description</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:location:latitude</td>
                            <td>Latitude. can be anything except blank (e.g. place:location:latitude).</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:location:longitude</td>
                            <td>Longitude. can be anything except blank (e.g. place:location:longitude).</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:image</td>
                            <td>Link to high resolution image.</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:street_address</td>
                            <td>Street address. can be anything except blank (e.g. place:street_address).</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:Keyword or Keyword</td>
                            <td>Contains all the tags/ Keywords seperated by comma, maximum 30 tags allowed these will be automatically converted to tags</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:Emotion</td>
                            <td>Contains all the Emotions seperated by comma, maximum 30 Emotions allowed these will be automatically converted to Emotion Tags</td>
                            <td>Y</td>
                        </tr>
                        <tr>
                            <td>og:locality</td>
                            <td>Locality (i.e. city). can be anything except blank (e.g. place:locality).</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:region</td>
                            <td>Region (i.e. state). can be anything except blank (e.g. place:region).</td>
                            <td>N</td>
                        </tr>
                        <tr>
                            <td>og:postal_code</td>
                            <td>Postal code. can be anything except blank (e.g. place:postal_code).</td>
                            <td>N</td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</asp:Content>