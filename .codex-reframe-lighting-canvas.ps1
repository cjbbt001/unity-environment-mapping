$ErrorActionPreference = 'Stop'

$canvasPath = 'E:\Obsidian\obsidian\TA\Kerry\光照技术.canvas'
$canvas = Get-Content -LiteralPath $canvasPath -Raw -Encoding UTF8 | ConvertFrom-Json

$oldNodeIds = @(
    'a41b7e2c90d5f683','b52c8f3da1e60794','c63d904eb2f718a5',
    'd74ea15fc30829b6','e85fb260d4193ac7','f960c371e52a4bd8',
    '0a71d482f63b5ce9','1b82e593074c6dfa','2c93f6a4185d7e0b',
    '3da407b5296e8f1c','4eb518c63a7f902d','5fc629d74b80a13e',
    '60d73ae85c91b24f','71e84bf96da2c350','82f95c0a7eb3d461'
)

$canvas.edges = @($canvas.edges | Where-Object {
    $_.fromNode -notin $oldNodeIds -and $_.toNode -notin $oldNodeIds
})
$canvas.nodes = @($canvas.nodes | Where-Object { $_.id -notin $oldNodeIds })

$newNodes = @(
    [pscustomobject]@{ id='a41b7e2c90d5f683'; type='text'; text='光照基本框架'; x=-118; y=1500; width=250; height=60; color='4' },
    [pscustomobject]@{ id='b52c8f3da1e60794'; type='text'; text='直接光照 Direct Lighting'; x=310; y=1160; width=300; height=60 },
    [pscustomobject]@{ id='c63d904eb2f718a5'; type='text'; text="直接漫反射 Diffuse`n- Lambert`n- N · L`n- Base Color"; x=716; y=1040; width=300; height=140 },
    [pscustomobject]@{ id='d74ea15fc30829b6'; type='text'; text="直接镜面反射 Specular`n- Blinn-Phong`n- 光源高光`n- 与观察方向有关"; x=716; y=1220; width=300; height=140 },
    [pscustomobject]@{ id='e85fb260d4193ac7'; type='text'; text='间接光照 Indirect Lighting'; x=310; y=1740; width=300; height=60 },
    [pscustomobject]@{ id='f960c371e52a4bd8'; type='text'; text='间接漫反射 Diffuse'; x=716; y=1540; width=300; height=60 },
    [pscustomobject]@{ id='0a71d482f63b5ce9'; type='text'; text="Diffuse IBL`n- 法线方向 N`n- Diffuse Convolution`n- 与观察方向无关"; x=1086; y=1440; width=330; height=150 },
    [pscustomobject]@{ id='1b82e593074c6dfa'; type='text'; text="球谐光照 SH`n- 压缩低频环境光`n- 9 个系数 / RGB`n- ShadeSH9"; x=1086; y=1640; width=330; height=150 },
    [pscustomobject]@{ id='2c93f6a4185d7e0b'; type='text'; text="Light Probe`n- 空间储存 SH`n- 四面体插值`n- Blend Probes"; x=1500; y=1640; width=300; height=150 },
    [pscustomobject]@{ id='3da407b5296e8f1c'; type='text'; text='间接镜面反射 Specular'; x=716; y=1940; width=300; height=60 },
    [pscustomobject]@{ id='4eb518c63a7f902d'; type='text'; text="Specular IBL`n- reflect(-V, N)`n- Roughness → Mip`n- texCUBElod"; x=1086; y=1840; width=330; height=150 },
    [pscustomobject]@{ id='5fc629d74b80a13e'; type='text'; text="Reflection Probe`n- 局部 Cubemap`n- unity_SpecCube0`n- Box Projection / Blending"; x=1086; y=2040; width=350; height=150 },
    [pscustomobject]@{ id='60d73ae85c91b24f'; type='text'; text="环境数据 Environment Map`n- Cubemap 六个面`n- float3 方向采样`n- HDR + DecodeHDR"; x=716; y=2180; width=330; height=150 }
)

$newEdges = @(
    [pscustomobject]@{ id='93a06d1b8fc4e572'; fromNode='a41b7e2c90d5f683'; fromSide='right'; toNode='b52c8f3da1e60794'; toSide='left' },
    [pscustomobject]@{ id='a4b17e2c90d5f683'; fromNode='a41b7e2c90d5f683'; fromSide='right'; toNode='e85fb260d4193ac7'; toSide='left' },
    [pscustomobject]@{ id='b5c28f3da1e60794'; fromNode='b52c8f3da1e60794'; fromSide='right'; toNode='c63d904eb2f718a5'; toSide='left' },
    [pscustomobject]@{ id='c6d3904eb2f718a5'; fromNode='b52c8f3da1e60794'; fromSide='right'; toNode='d74ea15fc30829b6'; toSide='left' },
    [pscustomobject]@{ id='d7e4a15fc30829b6'; fromNode='e85fb260d4193ac7'; fromSide='right'; toNode='f960c371e52a4bd8'; toSide='left' },
    [pscustomobject]@{ id='e8f5b260d4193ac7'; fromNode='e85fb260d4193ac7'; fromSide='right'; toNode='3da407b5296e8f1c'; toSide='left' },
    [pscustomobject]@{ id='f906c371e52a4bd8'; fromNode='e85fb260d4193ac7'; fromSide='right'; toNode='60d73ae85c91b24f'; toSide='left' },
    [pscustomobject]@{ id='0a17d482f63b5ce9'; fromNode='f960c371e52a4bd8'; fromSide='right'; toNode='0a71d482f63b5ce9'; toSide='left' },
    [pscustomobject]@{ id='1b28e593074c6dfa'; fromNode='f960c371e52a4bd8'; fromSide='right'; toNode='1b82e593074c6dfa'; toSide='left' },
    [pscustomobject]@{ id='2c39f6a4185d7e0b'; fromNode='1b82e593074c6dfa'; fromSide='right'; toNode='2c93f6a4185d7e0b'; toSide='left' },
    [pscustomobject]@{ id='3d4a07b5296e8f1c'; fromNode='3da407b5296e8f1c'; fromSide='right'; toNode='4eb518c63a7f902d'; toSide='left' },
    [pscustomobject]@{ id='4e5b18c63a7f902d'; fromNode='3da407b5296e8f1c'; fromSide='right'; toNode='5fc629d74b80a13e'; toSide='left' }
)

$allIds = @($canvas.nodes.id) + @($canvas.edges.id) + @($newNodes.id) + @($newEdges.id)
$duplicates = @($allIds | Group-Object | Where-Object Count -gt 1)
if ($duplicates.Count -gt 0) {
    throw "Duplicate canvas IDs: $($duplicates.Name -join ', ')"
}

$canvas.nodes = @($canvas.nodes) + $newNodes
$canvas.edges = @($canvas.edges) + $newEdges

$nodeIds = @($canvas.nodes.id)
$dangling = @($canvas.edges | Where-Object {
    $_.fromNode -notin $nodeIds -or $_.toNode -notin $nodeIds
})
if ($dangling.Count -gt 0) {
    throw "Canvas contains dangling edges: $($dangling.id -join ', ')"
}

$json = $canvas | ConvertTo-Json -Depth 10
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($canvasPath, $json, $utf8NoBom)

[pscustomobject]@{ Path=$canvasPath; Nodes=$canvas.nodes.Count; Edges=$canvas.edges.Count }
