pico-8 cartridge // http://www.pico-8.com
version 14
__lua__

function _init()

boat={
x = 5,
y = 5,
vx = 0,
vy = 0,
ax = 0,
ay = 0,
width = 16,
height = 16, 
collided = false,
frame = 0,
invulnerable = false
}

enemy = {
x = 60,
y = 60,
width = 8,
height = 8
}

enemylist = {}

enemynumber = 5

for i=1, enemynumber do

	add(enemylist,
	{i*20+rnd(1)*20,
	i*20+rnd(1)*20,
	8,8,0,0,0})
	
end

end

function _draw()
cls()
print(stat(1))
for v in all(enemylist) do
	spr(3,v[1], v[2])
	print(v[1])
end

if(boat.invulnerable == false) or
	(boat.frame%3 != 0) then
spr(1,boat.x,boat.y,2,2)
end

end


function _update60()

boat.collided = false

boatmovement()

for v in all(enemylist) do
	if(boxcollision(boat,v))
	and(boat.invulnerable == false) then
			boat.collided = true
			boat.invulnerable = true
			boat.frame = 0
	end
end

if boat.invulnerable then
boat.frame += 1
	if boat.frame == 50 then
		boat.invulnerable = false
	end
end

enemymovement()

end

function randombool()
return (flr(rnd(2)) == 1)
end

function enemymovement()

for e in all(enemylist) do


	if(e[7] == 0) then
	local direction = randombool()
		if randombool() == true then

if(direction == true) then
				e[5] = 0.4
			else
				e[5] = -0.4
			end
			
			e[6] = 0

		else

		if(direction == true) then
				e[6] = 0.4
			else
				e[6] = -0.4
			end
			
			e[5] = 0

		end
	end
	
	if e[6] == 0 then
		e[1]+=e[5]
	elseif e[5] == 0 then
		e[2]+=e[6]
	end
	
	if e[7] == 40 then
		e[7] = 0
	else
		e[7] += 1
	end

end

end

function boxcollision(rect1, index)

if (rect1.x < index[1] + index[3] and
   rect1.x + rect1.width > index[1] and
   rect1.y < index[2] + index[4] and
   rect1.height + rect1.y > index[2]) then
 		 return true
end

return false

end

function boatmovement()

    -- boat x acceleration
    boat.ax = 0
    if (btn(0)) boat.ax=-.25
    if (btn(1)) boat.ax=.25

    -- apply x accel
    boat.vx += boat.ax

    -- limit x max speed
    if boat.vx > 3 then
        boat.vx = 3
    elseif boat.vx < -3 then
        boat.vx = -3
    end

    -- drag
    if boat.ax == 0 then
        boat.vx *= 0.8
    end

    -- boat x acceleration
    boat.ay = 0
    if (btn(2)) boat.ay=-.25
    if (btn(3)) boat.ay=.25

    -- apply y accel
    boat.vy += boat.ay

    -- limit y max speed
    if boat.vy > 3 then
        boat.vy = 3
    elseif boat.vy < -3 then
        boat.vy = -3
    end

    -- drag
    if boat.ay == 0 then
        boat.vy *= 0.8
    end
    
boat.x += boat.vx
boat.y += boat.vy

end
__gfx__
00000000cccc7cccffffffffcccccccccccccccc35b35353fffff7ff65606650cccccccc0444444f0000000000020000300070d0000070000000000500000005
00000000cc7777ccffffffffccccccccccc76ccc5355335bffffffff66506650cccccccc004444f600020000030000d000000007000000000000055600050556
00000000c77ccc67ffffffffcccccccccccc76cc335b3535f7ffffff55506550cc7cc7cc00ffff66000370000000700020700000000000000000566600005666
0000000077ccccc6ffffffffccc7ccccccccc76c53335333fffff7ff000000007c77cc7c00ffff660001ad000007000000000000700000000005057650000756
000000007cccccc6ff6f7fffcc77ccccccccccccb553b535ffffffff660666066776777700ffff66007c08000010a70000000007000000000000000505050005
00000000c77cc67cf776767fcccc6ccccccccccc35353353fff7ffff650656066676657600ffff66000000000000700001070000000000070000055656505556
00000000cc7766cc77677677cccccccccccccccc53b55335fffffff76505550555065505005555460000000000c0080000000908000000000000566676507666
00000000ccc6cccc67766776cccccccccccccccc3553b53b7fffffff0000000000000000055555540000000000000000c0000000007000000005057666655566
cc6666cc000000000000000067766776000440000066555044545444660000666600006666000066000771110007711100077111566656665666566600080000
766776670000000000000000776776770888448806cc77c554445455607070066070700660707006077777700777777007777770056705670565056600088000
767007670000000000000000c776767c87888888066ccc65455445446080080660800806608008060f1f1ff00f1f1ff00f1f1ff00565056505670565008a9800
670000760000000000000000cc6c7ccc88788888066666655444544566000066660000666600006000effe0000effe0000effe0000500050005005750089a980
700440070000000000000000cccccccc8878888806666665445445440660066666600660666006600f9999f0009999f00f9999000005000505005005089aa980
c044440c0000000000000000cccccccc088888880566665545454445600000066000000660000006009999000f999900009999f0000000000000055600899800
c046440c0000000000000000cccccccc008888800556655554445544666446600664466660644666000440000004400000044000000000000000566600488400
c067540c0000000000000000cccccccc00000000005555504545445460060066660600066606600601f01f00001ff10000f1f100000000000005057600044000
c677540c0000000000000000cccccccc004444000000000000000000660000666600006666000066000771110007711100077111675050006655566600008000
c066440c0000000000000000cccccccc005555000000000000000000600000066000000660000006077777700777777007777770666500006667056700088000
c044440c0000000000000000cccccccc056eee50000400000002200060000006600000066000000607777770077777700777777065500000655505650089a800
c004400c0000000000000000cccccccc057eee50008648000007e00066000066660000666600006000f77f0000f77f0000f77f005000000050005050008a9980
cc0000cc0000000000000000cccccccc05e7ee50008888000007e0000660066666600660666006600f9999f0009999f00f9999006750500065700005089aa980
ccc00ccc0000000000000000cccccccc05eeee5000088000000ee000600000066000000660000006009999000f999900009999f0666500006665000000899800
cccccccc0000000000000000cccccccc05eeee500000000000000000666446600664466660644666000440000004400000044000655000006550500000488400
cccccccc0000000000000000cccccccc00555500000000000000000060060066660600066606600601f01f00001ff10000f1f100500000005000000000044000
00000000000000000000000000000000155555563333333356666667000000000000000000000000000220000002200000022000000000006750500000080000
00000000000000000000000005500000015555673355553356777776033303330333033303330333002e2200002e2200002e2200000000006665000000088000
0000000000000000000000000000000000666677354777535677777700a303a00a39093a0a39393a02ee2e2002ee2e2002ee2e20000000006550000000889800
0000000000000000000000000000055000666677354447535677777700393930003333308077777002ee2e2002ee2e2002ee2e2050005000500500500089a980
000000000000000000000000000000000066667735444753567777778033333080377730883777302ee2eee22eee2ee22eeee2e20500050057500500089aa980
000000000000000000000000055000000066667735444453567777778003330088033300880333002e6e6ee22e6e6ee22e6e6ee256505650565076500089a800
00000000000000000000000000000000011111573355553357666666303aaa30303aaa30033aaa3002eeee2002eeee2002eeee20765076506650565000488400
0000000000000000000000000000055011111115333333336555555533aaaaa333aaaaa333aaaa30202222002022220200222202666566656665666500044000
cccccccccccccccccccccccccccccccc044444400099990000099000000990000099990050505050333533350077770000777000000777000077700000777700
cccccccccccccccccccccccccccccccc49aaaa9409a00090009a09000090a90009000a9035353535333353500075575000755700007055500075570000755550
cccccccccccccccccccccccccccccccc4999999409a00090009a09000090a90009000a9033333333333533350075075000750750007500000075075000750000
cccccccccccccccccccccccccccccccc94477449097aaa900097a900009a790009aaa79035353535333353500077775000777050007500000075075000777000
cccccccccccccccccccccccccccccccc9aa55aa90099990000090000000090000099990053535353333533350075575000755700007500000075075000755500
cccccccccccccccccccccccccccccccc9aaaaaa90009a0000009a000000a9000000a900033333333333353500075075000750750007500000075075000750000
cccccccccccccccccccccccccccccccc9aaaaaa90009000000090000000090000000900033333333333533350075075000777050000777000077705000777700
cccccccccccccccccccccccccccccccc999999990009a0000009a000000a9000000a900033333333333353500005005000055500000055500005550000055550
cccccccccccc76500000000005667ccc044774400000000000000000000000000000000000000000000000000077770000077700007007000077770000777700
ccccccccccc77700505560550567cccc499999940870088008700880087000800870008008000000000000000075555000705500007507500007555000055750
cc7cc7cccc7c755067566766007777cc49aaaa948787888887870888878708888787008887000008800000080075000000750000007507500007500000000750
7c77cc7ccccc76507777677606667ccc944444498788888887888888870008888700088887000088000000000077700000757700007777500007500000700750
67767777ccc76660c7cc77c70567cccc9aa55aa90878888008708880087088800870088008700080080000800075550000750750007557500007500000750750
66766576cc777700cc7cc7cc0557c7cc9aaaaaa90087880000878800008788000080080000800800000008000075000000750750007507500007500000750750
55065505cccc7650cccccccc00777ccc9aaaaaa90008800000008000000880000000800000000000000000000075000000077050007507500077770000077750
00000000ccc76650cccccccc0567cccc999999990000000000000000000000000000000000000000000000000005000000005500000500500005555000005550
cccccccccc3333cccc3333cccccccccc007777000000070000777700007777000070070000700700007000000077770000700700007777000077770000077000
ccccccc3333333333333333ccccccccc007557500000075000055750000557500075075000750750007500000077775000770750007557500075575000705700
cccc3333333333333333333ccccccccc007507500000075000000750000007500075075000757050007500000075575000757750007507500075075000750750
ccc33333335533333333333ccccccccc007507500000075000777750007777500077775000770500007500000075075000757750007507500077775000750750
cc33333335553333333333333ccccccc007507500000075000755550000557500005575000757000007500000075075000755750007507500075555000750750
cc3333333c5333333333333333cccccc007507500000075000750000000007500000075000750700007500000075075000750750007507500075000000757050
533333337c55333333333333333ccccc007777500000075000777700007777500000075000750750007777000075075000750750007777500075000000070700
553355337c553333333333333b3ccccc000555500000005000055550000555500000005000050050000555500005005000050550000555500005000000005050
f5b55533cc5553b33b3333b33b3ccccc007777000077770000777700007777000077770000777000000777000077770000700700007007000070070000700700
f5b35553c73b53b33bbb33b333b3cccc007555500075555000055750007557500075575000755700007055500007555000750750007507500075075000750750
f5bb33577b3bb33bb3b3bb3bbb3333cc007500000075000000000750007507500075075000750750007500000007500000750750007507500075075000750750
ff5bb3333bb3b5333b3bbb33bbbbbb3c007777000077770000000750007777500077775000777050000770000007500000750750007507500075075000077050
cff53bb3b3b3555533bb3bbb3bbb3b35000557500075575000000750007557500005575000755700000057000007500000750750007507500077075000705700
ccff53b3bb33555bb3b33b33bbbbb555000007500075075000000750007507500000075000750750000007500007500000750750007570500075775000750750
cccff53b333b3bb333bb33b33355555f007777500077775000000750007777500000075000750750007770500007500000077050000705000075075000750750
ccccfff5535bb3bbbbbbbbb55555555f000555500005555000000050000555500000005000050050000555000000500000005500000050000005005000050050
ccccccfff55555555555555555555fff000000000007000000000000000000000700000000000000007788000088800000000000000000000000000000000000
ccccccccfffffffff555555555ffffcc000007000076600000000000000700000000000000000000088887800877880000778800000000000000000000000000
cccccccccccffffffff5555ffffffccc000006700766660000000700000000700000700070000000778888870788878007888780000000000000000000000000
cccccccccccccccccfffffffffcccccc999956670005000000000007000070000070000000000000888778887887788778877887000000000000000000000000
cccccccccccccccccccccccccccccccc000006600009000000000700000000700000000000700000078888700788887007888870000000000000000000000000
cccccccccccccccccccccccccccccccc0000060000090000000000000007000000700000000000000081f1000881f1800881f180000000000000000000000000
cccccccccccccccccccccccccccccccc000000000009000000000000000000007000000000000000000ff000000ff000000ff000000000000000000000000000
cccccccccccccccccccccccccccccccc00000000000900000000000000000000000000007000000000ffff0000ffff0000ffff00000000000000000000000000
0070070000777700ccc77750000000000000000005667ccc34444443355555530000000055555555566666656555555600000000000000000000000000000000
0075075000055750cccc765055565500005560550567cccc44999944556666550000000055666655665555665577775500000000000000000000000000000000
0075075000007050cc7cc7507676655005566766007777cc499ff994566776650000000056655665655775565777777500000000000000000000000000000000
00077050000705007c77c66077cc76500567677606667cc749f77f94567777650000000056577565657777565777777500000000000000000000000000000000
0007550000705000677676507cc76660066c77c70567cc7749f77f94567777650000000056577565657777565777777500000000000000000000000000000000
000750000075000066766550cc777700057cc7cc05566767499ff994566776650000000056655665655775565777777500000000000000000000000000000000
000750000077770055065500cccc76500567cccc0055655544999944556666550000000055666655665555665577775500000000000000000000000000000000
000050000005555000000000ccc7665005777ccc0000000034444443355555530000000055555555566666656555555600000000000000000000000000000000
33222222222222330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
322eeee72eeee2330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
222ee27222eee2220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2eeeee2ee22e22e70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2eeeee2ee72eeee70000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2e2eee2e772222270000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2e7222e772ee7ee20000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2e72eee222ee72ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2e72eeeeee2772ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2e72e222222722ee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
32e2eeeee722ee220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3322227772eeee230000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
353332222522223b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3b3b3334445533530000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3335333454533b330000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
5b33b3445445353b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000

__gff__
0000000000000001000000000000000001000000000000010101020202000000000000000000000101010202020000000000000000000000000000000000000000000000000000000002000000000000010100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
34343434343434343434343434343434343434343434343434343434343434340303363607070707070707070707070707070707070707070707070707070707000000000000000000ededededededededededededededededededededededededededededededededededededededededededededededededededededededed
340505050505050505050505050505050505050505050505050505050505053403030606072e3344331e072e1d1d1d1d1e072e1d1d1d1d1f0716161616161607000000000000000000ededededededededededededededededededededededededededededededededededededededededededededededededededededededed
3405050505050505050505050505050505050505050505050505050505050534030306060733339b333333333333333333073333333333330e16161616161607000000000000000000ededededededededededededededededededededededededededededededededededededededededededededededededededededededed
34050505050505050505050505050505050505050505050505050505050505340303060607333333333333333333333333073333333333330e16161616161607000000000000000000ededed00ededededededededededededededededededededededededededededededededededededededededededededededededededed
340505050505050505050505050505050505050505050505059605050505053403030606073e3333330f2e333333333333073333330707070707070707070707000000000000000000ededed0000edededededededededededededededededededededededededededededededededededededededededededededededededed
3405050505050505050505050505050505050505050505050505050505050534030306061e070707072e1f33331f3d3d3d0733333307331f0716161644161607ededededededededededededed000000ed000000edededededededededededededededededededededededededededededededededededededededededededed
3405050505050505050505050505050505050505050505050505050505050534030306061f1d1d1d1d3333333307333333073333330733330e16161616161607edededededededededededed0000ed00edededed0000000000ededededededededededededededededededededededededededededededededededededededed
340505050505050505050505050505050505050505050505a0a10505050505340303060633333333333333333307333333073333330733330e16161616161607edededededededededededededed00ededededededededededededededededededededededededededededededededededededededededededededededededed
340505050505050505050505050505050505050505050505b0b1050505050534030306061f3d3d3d3d333333330733389b0733333307331f0716161616161607edededededededededededededed00ededededededededededededededededededededededededededededededededededededededededededededededededed
3405050505050505050505050505050505050505050505050505050505050534030306060f070707073e1f33331f0707071f3333330733330707070707070707edededededededededededededed00ededededededededededededededededededededededededededededededededededededededededededededededededed
340505050505050505050505050505050505050505050505050505050505053403030606072e3344331e3e3333331e072e3333333307331f071616161616160700ed0000000000000000000000ededededededededededededededededededededededededededededededededededededededededededededededededededed
3405343434343434053434343434340606060634343434343434343405343434030306060733333333333333333333079b333333330733330e16161616161607000000000000000000000000edededededededededededededededededededededededededededededededededededededededededededededededededededed
34060606060606060606060606060606060606060606060606060606060606340303060607334533333333333333333333333333333333330e1616161616160700000000000000000000000000edededed00edededededededededededededededededededededededededededededededededededededededededededededed
340202020202020202020202020202020202020202020202020202020202023403030606073e3333330f073e33333333333333333333331f0716161616161607000000000000000000000000edededed000000000000edededededededededededededededededededededededededededededededededededededededededed
0703030303030303030303030303030303030303030303030303030303030303030336360707070707070707070707070707070707070707070707070707070700000000000000000000000000edededed000000000000ededededededededededededededededededededededededededededededededededededededededed
34343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434000000000000000000000000000000000000000000000000000000edededededededededededededededededededededededededededededededed0000000000
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534000000000000000000000000000000000000000000000000000000edededededededededededededededededededededededededededededededed0000000000
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534ed00000000000000ed0000edededededededededededededededededededededededededededededededededededededededededededededededededededed00
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534ededed00ed000000000000edededededededededededededededededededededededededededededededededededededededededededededededededededed00
34050505050505050505050505050505050505050505050505960505050505343405050505050505050505050505050505050505050505050596050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
340505050505050505050505050505050505050505050505a0a1050505050534340505050505050505050505050505050505050505050505a0a1050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
340505050505050505050505050505050505050505050505b0b1050505050534340505050505050505050505050505050505050505050505b0b1050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34050505050505050505050505050505050505050505050505050505050505343405050505050505050505050505050505050505050505050505050505050534ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34053434343434340534343434343406060606343434343434343434053434343405343434343434053434343434340606060634343434343434343405343434ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34060606060606060606060606060606060606060606060606060606060606343406060606060606060606060606060606060606060606060606060606060634ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
34020202020202020202020202020202020202020202020202020202020202343402020202020202020202020202020202020202020202020202020202020234ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
03030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303030303ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000edededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed00
000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededededed
__sfx__
010100000361003610016100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
012800001f6201f6201f6200c6100c6100c6100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010c00101b05000000000001b05000000000001e05000000200500000021050000002005000000210500000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010c00101b05300000000001b05300000000001e05300000200530000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000024623000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000024051000003000000600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010c000021142211422414224142201422014223142231421f1421f14222142221421d1421d1421d1421d14200000000000000000000000000000000000000000000000000000000000000000000000000000000
000c000021030210302103021030200302003020030200301f0301f0301f0301f0301d0301d0301d0301d03000000000000000000000000000000000000000000000000000000000000000000000000000000000
0114000015520185301a550000001a550000001a5501c5501d550000001d550000001d5501f5501c550000001c550000001a55018550185501a550000000000015550185501a550000001a550000001a5501c550
011400001d550000001d550000001d5501f5501c550000001c550000001a550185501a55000000000000000015550185501a550000001a550000001a5501d5501f550000001f550000001f550215502255000000
011400002255000000215501f550215501a55000000000001a5501c5501d550000001d550000001f55000000215501a55000000000001a5501d5501c550000001c550000001d5501a5501c550000000000000000
0114000015550185501c550000001c550000001a550195501a550000001a550000001c550000001d550000001d5501d5501f55000000215502155021550215501d5501a550155501555015550000000000000000
01140000225502255022550225501d5501a550175501755017550000001a5501c5501d550000001d550000001f55000000215501a550000001a5501d5501c550000001c550000001d5401c5301a5201a52000000
0114000000000000001155000000115500000015550185501a550000001a550000001a5501c550185500000018550000001655015550115501155000000000000000000000165500000016550000001655018550
011400001555000000155500000015550165501355000000135500000011550105501155000000000000000000000000001155011550115501155011550115501a5501a5501a5501a5501a5501a5501a5501a550
011400001a5501a5501a5501a5501155011550115501155011550115501a5501a5501a5501a5501a5501a550115501155011550115501155011550195500000019550000001a5501755019550000000000000000
011400000000000000195500000019550000001655015550115500000011550000001355000000155500000015550155501655000000115501155011550115501555011550105501055010550000000000000000
011400001355013550135501355017550115500e5500e5500e5500000000000000001a5501a5501a5501a5501a5501a550115501155011550115501155011550000001955000000195401a5301a5201a52000000
0114000000000000000e5500e5500e5500e5500e5500e5501655016550165501655016550165501555015550155501555015550155500e5500e5500e5500e5500e5500e550115501155011550115501155011550
011400000c5500c5500c5500c5500c5500c5500c5500c5500c5500c5500c5500c5500e5500e5500e5500e5500e5500e5500e5500e5500e5500e5500e5500e5501655016550165501655016550165501355013550
01140000135501355013550135500e5500e5500e5500e5500e5500e5501655016550165501655016550165500e5500e5500e5500e5500e5500e55015550155501555015550155501555015555155551555515550
0114000015550155501555015550155501555011550105500e550000000e550000000d550000000c550000000c5500c5500e550000000e5500e5500e5500e5500e5500e5500d5500d5500d5500c5500c5500c550
011400000e5500e5500e5500e5500e5500e5501355013550135100000000000000001655016550165501655016550165500e5500e5500e5500e5500e5500e5501355013550135501354013530135201352000000
011400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
011000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
01 080d1257
01 090e1318
01 0a0f1444
01 0b101544
01 0c111644
00 080d1244
00 4a4f5444
00 4c515644
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344
00 41424344

