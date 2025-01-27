.REMOVE_ON_ERROR:
.SECONDARY:

.PHONY: clean install
clean:
	@ rm -f *.png*
	@ echo "all clean"

install:
	@ mv -f *.png samples/follow\* 2>/dev/null || echo 

% :
	@ echo "retrieving $*'s identicon"
	@ make -s $*.png
	@ echo "converting $*'s identicon"
	@ make -s $*_no_back.png
	@ make -s $*_light.png
	@ make -s $*_dark.png
	@ make -s $*_white.png
	@ make -s $*_black.png
	@ echo "$* done."

%.png :
	wget -q https://github.com/identicons/$*.png

%_no_back.png : %.png
	./convert.sh $* transparent no_back

%_light.png : %.png
	./convert.sh $* "#F0F0F0" light

%_dark.png : %.png
	./convert.sh $* "#2E3436" dark

%_white.png : %.png
	./convert.sh $* "#FFFFFF" white

%_black.png : %.png
	./convert.sh $* "#000000" black
