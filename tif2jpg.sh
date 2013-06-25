for f in *.tif; do
    echo "Converting $f to 72dpi";
    convert "$f" +profile 8bim -density 72 "$(basename "$f" .tif).jpg";
done;

while getopts ":rk" opt; do
    case $opt in
        r)
            echo "Resizing to 2048x1536" >&2
            find . -type f -name "*.jpg" -exec mogrify -resize 2048x1536^ -extent 2048x1536 -gravity center {} \;
        ;;
        k)
            keep=$opt
        ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
        ;;
    esac
done

if [ ${keep:-"keep"}  = "k" ]; then
    echo "Keeping the tifs" >&2
else
    echo "Deleting the tifs" >&2
    rm *.tif
fi
