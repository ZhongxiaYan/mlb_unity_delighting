require 'torch'
require 'paths'
require 'image'
require 'nn'
require 'nngraph'
require 'cunn'
require 'cudnn'

local cmd = torch.CmdLine()

cmd:option('-input', '', 'input image')
cmd:option('-mask', '', 'input mask')
cmd:option('-model', '', 'model file')
cmd:option('-outdir', '.', 'output directory')
cmd:option('-gpu', 1, 'use GPU')

local options = cmd:parse(arg)

-- load model
local model = torch.load('model.t7')

--print(model.modules[1].weights)
--[[print('-----')
print(#model:float():parameters())
print('-----')
print(model:parameters()[1])
--]]
params = model:parameters()
file = io.open("model_weights_all.txt", "w")
for i=1, #params  do
  file:write(tostring(params[i]))
  print(i)
end

file:close()
--[[
-- load input image and mask
input[{1, {}, {}, {}}] = image.scale(image.load(options.input, 3), 256, 256)
--mask[{1, {}, {}, {}}]  = image.scale(image.load(options.mask,  3), 256, 256)

if options.gpu == 0 then
  model:float()
else  
  model:cuda()
  input = input:cuda()
  --mask = mask:cuda()
end

local pred = model:forward(input)


image.save(paths.concat(options.outdir, 'albedo.png'), pred[1]:squeeze())
image.save(paths.concat(options.outdir, 'shading.png'), pred[2]:squeeze())
image.save(paths.concat(options.outdir, 'specular.png'), pred[3]:squeeze())

--EOF



-- save output
image.save(paths.concat(options.outdir, 'albedo.png'), pred[1]:cmul(mask):squeeze())
image.save(paths.concat(options.outdir, 'shading.png'), pred[2]:cmul(mask):squeeze())
image.save(paths.concat(options.outdir, 'specular.png'), pred[3]:cmul(mask):squeeze())
-- save a copy of input
image.save(paths.concat(options.outdir, 'input.png'), input:squeeze())
image.save(paths.concat(options.outdir, 'mask.png'), mask:squeeze())

--EOF
--]]
