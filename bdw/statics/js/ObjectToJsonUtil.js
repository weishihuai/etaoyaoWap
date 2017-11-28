/*!
 Convert the Object to JSON
 */
function _ObjectToJSONNoMethod(value){
    return _ToJSON(value);
}
function _ObjectToJSON(method,value){
    return '_method='+method+'&json='+ _ToJSON(value);
}
function _ToJSON(o) {
    if (o == null)
        return "null";
    //constructor--->Property returns to create this object reference to the array functions
    switch (o.constructor) {
        case String:
            var s = o; // .encodeURI();
            if (s.indexOf("}") < 0)s = '"' + s.replace(/(["\\])/g, '\\$1') + '"';
            s = s.replace(/\n/g, "\\n");
            s = s.replace(/\r/g, "\\r");
          /*  s = s.replace(/\t/g, "\\t");
            s=    s.replace("\"","\\\"");*/
            return s;
        case Array:
            var v = [];
            for (var i = 0; i < o.length; i++)
                v.push(_ToJSON(o[i]));
            if (v.length <= 0)return "\"\"";
            return "[" + v.join(",") + "]";
        case Number:
            return isFinite(o) ? o.toString() : _ToJSON(null);
        case Boolean:
            return o.toString();
        case Date:
            var d = new Object();
            d.__type = "System.DateTime";
            d.Year = o.getUTCFullYear();
            d.Month = o.getUTCMonth() + 1;
            d.Day = o.getUTCDate();
            d.Hour = o.getUTCHours();
            d.Minute = o.getUTCMinutes();
            d.Second = o.getUTCSeconds();
            d.Millisecond = o.getUTCMilliseconds();
            d.TimezoneOffset = o.getTimezoneOffset();
            return _ToJSON(d);
        default:
            if (o["toJSON"] != null && typeof o["toJSON"] == "function")
                return o.toJSON();
            if (typeof o == "object") {
                var v = [];
                for (attr in o) {
                    if (typeof o[attr] != "function")
                        v.push('"' + attr + '": ' + _ToJSON(o[attr]));
                }

                if (v.length > 0)
                    return "{" + v.join(",") + "}";
                else
                    return "{}";
            }
            alert(o.toString());
            return o.toString();
    }
};