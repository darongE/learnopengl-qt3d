import QtQuick 2.6 as QQ2

import Qt3D.Core 2.0
import Qt3D.Render 2.0

import "Components"
import "Components/misc.js" as Misc

Scene0 {
	Entity {
		id: root

		RenderSettings0 {}

		Entity {
			id: background
			components: [geometry, material]

			Material {
				id: material
				effect: Effect {
					techniques: Technique {
						renderPasses: RenderPass {
							renderStates: CullFace { mode: CullFace.NoCulling }
							shaderProgram: ShaderProgram0 {
								vertName: "texture"
								fragName: "texture"
							}
						}
					}

					parameters: Parameter {
						name: "ourTexture"
						value: Texture2D {
							minificationFilter: Texture.Nearest
							magnificationFilter: Texture.Nearest
							wrapMode {
								x: WrapMode.ClampToEdge
								y: WrapMode.ClampToBorder
							}
							TextureImage {
								source: Resources.texture("container.jpg")
							}
						}
					}
				}
			}

			Buffer {
				id: vertexBuffer
				type: Buffer.VertexBuffer
				data: (function () {
					var vertexArray = new Float32Array(8 * 4)
					var vertices = [
						// Positions      // Colors        // Texture Coords
						 0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0, // Top Right
						 0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0, // Bottom Right
						-0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0, // Bottom Left
						-0.5,  0.5, 0.0,   1.0, 1.0, 0.0,   0.0, 1.0  // Top Left
					]
					Misc.copyArray(vertices, vertexArray)
					return vertexArray
				})()
				}

			GeometryRenderer {
				id: geometry
				geometry: Geometry {
					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 0
						byteStride: 8 * 4
						name: defaultPositionAttributeName()
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 3
						count: 4
						byteOffset: 3 * 4
						byteStride: 8 * 4
						name: defaultColorAttributeName()
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.VertexAttribute
						vertexBaseType: Attribute.Float
						vertexSize: 2
						count: 4
						byteOffset: 6 * 4
						byteStride: 8 * 4
						name: defaultTextureCoordinateAttributeName()
						buffer: vertexBuffer
					}

					Attribute {
						attributeType: Attribute.IndexAttribute
						vertexBaseType: Attribute.UnsignedShort
						vertexSize: 1
						count: 6
						buffer: Buffer {
							type: Buffer.IndexBuffer
							data: (function () {
								var indexArray = new Uint16Array(3 * 2)
								var indices = [
											0, 1, 3,  // First Triangle
											1, 2, 3   // Second Triangle
										]
								Misc.copyArray(indices, indexArray)
								return indexArray
							})()
						}
					}
				}
			}
		}
	}
}
