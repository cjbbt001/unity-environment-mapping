# Unity Environment Mapping

基于 Unity Built-in Render Pipeline 的环境映射与材质练习项目。从 Cubemap 环境反射出发，逐步学习 IBL、Spherical Harmonics、Reflection Probe 与 Light Probe，最后综合实现玉石材质。

<p align="center">
  <img src="Screenshots/jade_left.png" width="48%" alt="玉石材质左侧效果">
  <img src="Screenshots/jade_right.png" width="48%" alt="玉石材质右侧效果">
</p>

## Cubemap 与 Reflection Probe

- 使用世界空间视线和法线计算反射方向，再采样 Cubemap。
- 理解 LatLong 全景图与 Cubemap 的方向映射关系。
- 使用 HDR 环境贴图保留高亮度信息，并进行 HDR 解码。
- 加入 Normal Map 与 AO，丰富反射细节和结构层次。
- 使用 Reflection Probe 获取场景局部环境反射。

<p align="center">
  <img src="Screenshots/CubeMap.png" width="32%" alt="基础 Cubemap 反射">
  <img src="Screenshots/CubeMap_AO%2BNormal.png" width="32%" alt="法线与 AO 参与的 Cubemap 反射">
  <img src="Screenshots/ReflectionProbe.png" width="32%" alt="Reflection Probe">
</p>

## Image-Based Lighting

- **Specular IBL**：根据反射方向采样预过滤 Cubemap。
- **Roughness**：使用粗糙度控制 Mipmap 层级，形成清晰或模糊的环境反射。
- **Diffuse IBL**：按法线方向获取低频环境颜色，近似环境漫反射。
- **Reflection Probe IBL**：使用 Unity 提供的局部 Probe 数据替代固定 Cubemap。
- 环境贴图是光照数据，IBL 是利用环境贴图计算光照的方法。

<p align="center">
  <img src="Screenshots/IBL.png" width="32%" alt="Specular IBL">
  <img src="Screenshots/IBL_Diffuse.png" width="32%" alt="Diffuse IBL">
  <img src="Screenshots/IBL_ReflectionProbe.png" width="32%" alt="Reflection Probe IBL">
</p>

## Spherical Harmonics 与 Light Probe

- SH 使用少量系数近似低频环境光，适合表现漫反射间接光。
- 项目实现了二阶 SH 的手动求值，用于理解 Unity 的 SH 数据结构。
- Light Probe 在空间中烘焙并保存 SH，动态物体可在探针之间插值环境光。
- Reflection Probe 主要提供高频镜面反射，Light Probe 主要提供低频漫反射光照。

<p align="center">
  <img src="Screenshots/SH.png" width="48%" alt="手动球谐光照">
  <img src="Screenshots/LightProbe.png" width="48%" alt="Unity Light Probe">
</p>

## 玉石材质

最终材质由以下部分组合：

- **基础漫反射与天光**：保留玉石固有色和实体感。
- **厚度背光透射**：根据视线、光线、法线与 Thickness Map 近似薄处透光。
- **环境反射**：通过 Cubemap 表现光滑表面。
- **Fresnel**：增强轮廓区域反射，减弱正面反射。
- **ForwardAdd**：为点光源和聚光灯逐灯叠加带衰减的透射光。
- 该效果是实时视觉近似，并非物理精确的次表面散射。

| 漫反射 | 厚度透射 | Cubemap 反射 |
| --- | --- | --- |
| ![玉石漫反射](Screenshots/jade_diffuse.png) | ![玉石透射](Screenshots/jade_tanslight.png) | ![玉石环境反射](Screenshots/jade_cubemap.png) |

| Fresnel | ForwardAdd | 最终效果 |
| --- | --- | --- |
| ![玉石 Fresnel](Screenshots/jade_fresnel.png) | ![玉石 ForwardAdd](Screenshots/jade_fwdadd.png) | ![玉石最终效果](Screenshots/jade_right.png) |

## 项目信息

- Unity `6000.3.16f1`
- Built-in Render Pipeline
- Post Processing `3.5.4`
- ShaderLab / HLSL
- Git LFS
