(function($) {

    // Auto Size Text is a plugin that allows you to programatically change teh 
    // font size of an element.  Often times when you have a common layout, and
    // dynamic content, you may find headers and certain text boxes overflow.  
    // With Auto Size Text, you can have it reduce the font so that it fits perfectly
    // or even break the text on to multiple lines.
    //

    $.fn.autoFitText = function(method) {

        // plugin's default options
        var defaults = {
            minFontSize: 10, // The smallest font size you want to let the text go to (in pixels)
            maxFontSize: 16 // Your starting font size.  
        }

        var settings = {}

        /* 
         * public methods
         * to keep the $.fn namespace uncluttered, collect all of the plugin's methods in an object literal and call
         * them by passing the string name of the method to the plugin
         * 
         * public methods can be called as
         * $(selector).autoFitText('methodName', arg1, arg2, ... argn)
         * where "autoFitText" is the name of your plugin and "methodName" is the name of a function available in
         * the "methods" object below; arg1 ... argn are arguments to be passed to the method
         * 
         * or, from within the plugin itself, as
         * methods.methodName(arg1, arg2, ... argn)
         * where "methodName" is the name of a function available in the "methods" object below
         */

        var methods = {

            // this the constructor method that gets called when the object is created
            init: function(options) {

                // the plugin's final properties are the merged default and user-provided properties (if any)
                // this has the advantage of not polluting the defaults, making the same instace re-usable with
                // new options; thanks to Steven Black for suggesting this
                settings = $.extend({},
                defaults, options)

                // iterate through all the DOM elements we are attaching the plugin to
                return this.each(function() {

                    // "element" holds the jQuery version of the current DOM element
                    // "this" refers to the actual DOM element
                    var element = $(this);
                    methods.autoFitText(element)
                    // code goes here
                });

            },

            // Public: Autosize the text to make sure the text fits within the container element
            //
            // minFontSize: 10, // The smallest font size you want to let the text go to (in pixels)
            // maxFontSize: 16, // Your starting font size.  
            //
            // Returns: the jQuery elements 
            //
            // Examples
            //
            //   $('div#header').autoFitText({maxFontSize: 20, minFontSize:10})
            //   
            //
            // Returns the duplicated String.
            autoFitText: function(element) {
                var minFontSize = settings.minFontSize
                var fontSize = settings.maxFontSize;
                var maxHeight = element.height();
                var maxWidth = element.width();
                var ourText = $('span:visible:first', element);
                ourText.css('font-size', fontSize);

                var textWidth = ourText.width();
                var textHeight = ourText.height();
                
                // console.log("Name: "+ ourText.text());
                // console.log("MaxWidth: " + maxWidth)
                // console.log("TextWidth: "+ textWidth);
                // console.log("MaxHeight: " + maxHeight)
                // console.log("TextHeight: "+ textHeight);
                
                do {
                    // console.log('dec')
                    ourText.css('font-size', fontSize);
                    textHeight = ourText.height();
                    textWidth = ourText.width();
                    fontSize = fontSize - 1;
                    // console.log(textHeight > maxHeight || textWidth > maxWidth);
                    // console.log("TextWidth: " + textWidth);
                    // console.log("MaxWidth: " + maxWidth);
                } while ((textHeight > maxHeight || textWidth > maxWidth) && fontSize > minFontSize);
                return element;
            }
        }

        // private methods
        // these methods can be called only from within the plugin
        //
        // private methods can be called as
        // helpers.methodName(arg1, arg2, ... argn)
        // where "methodName" is the name of a function available in the "helpers" object below; arg1 ... argn are
        // arguments to be passed to the method
        var helpers = {

            // a private method. for demonstration purposes only - remove it!
            splitStringOnMiddleSpace: function(str) {
              var string = $.trim(str);
              var charArray = string.split("");
              var middle = string.length/2;
              var closestToMiddle = 0;
              var i = 0;
              do {
                if(charArray[i] == ' '){
                  closestToMiddle = i;
                }
                i++;
              } while (i < string.length && middle - i > 0)
              var start = string.substr(0, closestToMiddle);
              var last = string.substr(closestToMiddle+1, string.length + 1 );
              return start + "<br />" + last;
            }

        }

        // if a method as the given argument exists
        if (methods[method]) {

            // call the respective method
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));

            // if an object is given as method OR nothing is given as argument
        } else if (typeof method === 'object' || !method) {

            // call the initialization method
            return methods.init.apply(this, arguments);

            // otherwise
        } else {

            // trigger an error
            $.error('Method "' + method + '" does not exist in autoFitText plugin!');

        }

    }

})(jQuery);