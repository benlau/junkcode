.pragma library

/* Android Context - A helper library for Android
 */

/* Density = Activity.getResources().getDisplayMetrics().density;

    0.75 - ldpi
    1.0 - mdpi (Default: 160DPI)
    1.5 - hdpi
    2.0 - xhdpi
    3.0 - xxhdpi
    4.0 - xxxhdpi
 */

var m_density = 1;

function init(context) {
    m_density = context.density;
}

/* Return dp to pixel
 */

function pixel(val) {
    /* Formula px to dp, dp to px android - Stack Overflow
    http://stackoverflow.com/questions/8309354/formula-px-to-dp-dp-to-px-android
    */
    var ret = Math.round(val * m_density);
    return ret;
}

function density() {
    return m_density;
}

