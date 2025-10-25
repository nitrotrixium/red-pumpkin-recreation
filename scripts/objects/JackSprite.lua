local JackSprite, super = Class(ActorSprite, "JackSprite")

-- Override functions from ActorSprite in here to change your sprite's functionality

function JackSprite:init(actor)
    super.init(self,actor)
    
    self.mouth = Sprite(actor.mouth)

    self.actordata = actor
    self.mouth:setOriginExact(51,63)
    self.mouth.x = self.mouth.x + 51
    self.mouth.y = self.mouth.y + 63

    self.head = Sprite(actor.head)
    
    self.head:setOriginExact(51,42)
    self.head.x = self.head.x + 51
    self.head.y = self.head.y + 42
    self.mouthtempscale = self.mouth.scale_y
    self.headtempscale = self.head.scale_y
    self.mouthtempy = self.mouth.y
    self.headtempy = self.head.y
    self:addChild(self.head)
    self:addChild(self.mouth)
    self.laughing = false
    self.myangle = 0
    self.laughingtime = 0
    self.idealmouthscale = 2
    self.mouthscale = 0
    
    self.ogscale = self.head.scale_y

    self.DTthing = 30
    self.sad = false

    self.laugh = function()
        self.laughing = true
    end

    self.toggleSad = function(self,tweentime)
        if not self.sadness then
            self.sadness = true
            local tt = tweentime or .5
            

            Game.stage.timer:tween(tt, self.mouth, {rotation = self.mouth.rotation - math.rad(180)},"out-circ",function()
                self.sadness = false
            end)

        

            
        end
    end
    
end



function JackSprite:update()
    super.update(self)

    
    
    
    local laughing = self.laughing
    local laughingtime = self.laughingtime
    local imgindex = 0
    if laughing then
        if self.laughingtime == 0 then
            Assets.playSound("jackolantern_laugh")
        end
        self.laughingtime = self.laughingtime + DTMULT

        local t = MathUtils.round(self.laughingtime) 
        

        if t == MathUtils.round(1.26) then
            imgindex = 1.2
        elseif t == MathUtils.round(5.67 ) then
            imgindex = 0
        elseif t == MathUtils.round(8.67) then
            imgindex = 1.1
        elseif t == MathUtils.round(10.95 ) then
            imgindex = 0
        elseif t == MathUtils.round(12.78 ) then
            imgindex = 1.05
        elseif t == MathUtils.round(15.36) then
            imgindex = 0
        elseif t == MathUtils.round(17.22 ) then
            imgindex = 1
        elseif t == MathUtils.round(20.22 ) then
            imgindex = 0
        elseif t == MathUtils.round(23.25 ) then
            imgindex = 0.95
        elseif t == MathUtils.round(26.19 ) then
            imgindex = 0
        elseif t == MathUtils.round(28.92 ) then
            imgindex = 0.95
        elseif t == MathUtils.round(32.04 ) then
            imgindex = 0
        elseif t == MathUtils.round(35.94 ) then
            imgindex = 0.8
        elseif t == MathUtils.round(40.65 ) then
            imgindex = 0
        elseif t == MathUtils.round(44.79 ) then
            imgindex = 0.7
        elseif t == MathUtils.round(49.26 ) then
            imgindex = 0
        elseif t > MathUtils.round(49.26 ) then
            self.laughing = false
        end
    else
        self.laughingtime = 0
    end

    

    self.idealmouthscale = 2 + (imgindex * 1.5);
    self.mouthscale = MathUtils.lerp(self.mouthscale, self.idealmouthscale, 1 - (0.5 ^ self.DTthing))
    
    self.idealwidth = 2 - (imgindex * 0.2);
    self.myangle = 0 + ((self.idealwidth - 2) * 8);
    self.headtempscale = MathUtils.lerp( self.headtempscale, self.idealwidth, 1- (0.6 ^ self.DTthing));
    self.drawy = MathUtils.lerp(0, 0 + ((2 - self.headtempscale) * 20), 1- (0.6 ^ self.DTthing));
    self.head.scale_y = self.headtempscale - 1
    
    self.head.rotation = -math.rad(self.myangle)

    if (self.mouthscale > 2.3) then
        self.head:setSprite(self.actordata.head.. "_2")
    else
        self.head:setSprite(self.actordata.head.. "_1")
    end

    self.DTthing = DTMULT
    
    self.mouthtempscale = self.mouthscale
    self.mouth.y = self.mouthtempy + self.drawy
    self.head.y = self.headtempy + self.drawy
    
    self.mouth.scale_y = self.mouthtempscale - 1
    
end



return JackSprite