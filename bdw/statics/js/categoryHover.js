/**
 * Created by Hgf on 2015/10/19.
 */
(function($) {
    $(document).ready(function () {

        if ($.trim(isIndex) != "Y"){
            $(".category .dd").hide();

            $(".category .dt").hover(function () {
                $(".category .dd").show();
                $("#trigger").hide();
            }, function () {
                $(".category .dd").hide();
                $("#trigger").show();
            });

            $(".category .dd").hover(function () {
                $(".category .dd").show();
                $("#trigger").hide();

            }, function () {
                $(".category .dd").hide();
                $("#trigger").show();

            });
        }

    });
})(jQuery);