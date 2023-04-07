with GrafikRecordKonstanten;

with TexturenSetzenSkalierenGrafik;
with Fehlermeldungssystem;
with SpritesverwaltungssystemGrafik;

package body KartenspritesZeichnenGrafik is
   
   procedure KartenfeldZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.KartenfeldZeichnen: TexturAccessExtern: null");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccessExtern     => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.Weltkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                          TextureAccessExtern => TexturAccessExtern),
                                       DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure StadtbewirtschaftungZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      GrößeExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtfeldZeichnen: TexturAccessExtern: null");
         
      else
         DurchsichtigesSpriteZeichnen (SpriteAccessExtern     => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => TexturenSetzenSkalierenGrafik.Stadtbewirtschaftung (SpriteAccessExtern  => SpriteAccess,
                                                                                                                     TextureAccessExtern => TexturAccessExtern,
                                                                                                                     GrößeExtern         => GrößeExtern),
                                       DurchsichtigkeitExtern => Sf.sfUint8'Last);
      end if;
      
   end StadtbewirtschaftungZeichnen;
   
   
   
   procedure StadtkarteZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtkarteZeichnen: TexturAccessExtern: null");
         
      else
         SpritesverwaltungssystemGrafik.PositionSkalierungZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                    PositionExtern     => GrafikRecordKonstanten.Nullposition,
                                                                    SkalierungExtern   => TexturenSetzenSkalierenGrafik.Stadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                    TextureAccessExtern => TexturAccessExtern));
      end if;
      
   end StadtkarteZeichnen;
   
   
   
   -- Das hier dann überall wo es möglich ist verwenden und den Rest entsprechend anpassen? äöü
   procedure SpriteZeichnenVariabel
     (PositionExtern : in Sf.System.Vector2.sfVector2f;
      GrößeExtern : in Sf.System.Vector2.sfVector2f;
      TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.SpriteZeichnenVariabel: TexturAccessExtern: null");
         
      else
         SpritesverwaltungssystemGrafik.PositionSkalierungZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                    PositionExtern     => PositionExtern,
                                                                    SkalierungExtern   => TexturenSetzenSkalierenGrafik.TexturskalierungVariabel (SpriteAccessExtern  => SpriteAccess,
                                                                                                                                                  TextureAccessExtern => TexturAccessExtern,
                                                                                                                                                  GrößeExtern         => GrößeExtern));
      end if;
      
   end SpriteZeichnenVariabel;
   
   

   procedure DurchsichtigesSpriteZeichnen
     (SpriteAccessExtern : in Sf.Graphics.sfSprite_Ptr;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin

      SpritesverwaltungssystemGrafik.PositionSkalieren (SpriteAccessExtern => SpriteAccessExtern,
                                                        PositionExtern     => PositionExtern,
                                                        SkalierungExtern   => SkalierungExtern);
      
      Farbe := Sf.Graphics.Sprite.getColor (sprite => SpriteAccessExtern);
      
      Farbe.a := DurchsichtigkeitExtern;
      
      SpritesverwaltungssystemGrafik.FarbeZeichnen (SpriteAccessExtern => SpriteAccessExtern,
                                                    FarbeExtern        => Farbe);
      
   end DurchsichtigesSpriteZeichnen;

end KartenspritesZeichnenGrafik;
