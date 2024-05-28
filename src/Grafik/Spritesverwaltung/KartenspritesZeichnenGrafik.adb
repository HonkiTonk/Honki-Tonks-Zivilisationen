with GrafikRecordKonstanten;
with GrafikKonstanten;
with EingeleseneTexturenGrafik;

with TexturenskalierungGrafik;
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
         Skalierung := TexturenskalierungGrafik.Weltkarte (SpriteAccessExtern  => SpriteAccess,
                                                           TextureAccessExtern => TexturAccessExtern);
         
         DurchsichtigesSpriteZeichnen (SpriteAccessExtern     => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => Skalierung,
                                       DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure KartenfeldZeichnenNeu
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
                 
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.KartenfeldZeichnenNeu: TexturAccessExtern: null");
         
      else
         Skalierung := TexturenskalierungGrafik.Kartenfeldskalierung (TexturengrößeExtern => (Sf.sfUint32 (TexturbereichExtern.width), Sf.sfUint32 (TexturbereichExtern.height)));
      
         Farbe := Sf.Graphics.Sprite.getColor (sprite => SpriteAccess);
      
         Farbe.a := DurchsichtigkeitExtern;
      
         SpritesverwaltungssystemGrafik.SetzenBereichPositionFarbeSkalierenZeichnen (SpriteAccessExtern  => SpriteAccess,
                                                                                     TexturExtern        => EingeleseneTexturenGrafik.BasisgrundAccess,
                                                                                     TexturbereichExtern => TexturbereichExtern,
                                                                                     PositionExtern      => PositionExtern,
                                                                                     SkalierungExtern    => Skalierung,
                                                                                     FarbeExtern         => Farbe);
      end if;
      
   end KartenfeldZeichnenNeu;
   
   
   
   procedure StadtbewirtschaftungZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenbereichExtern : in Sf.System.Vector2.sfVector2f;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         Fehlermeldungssystem.Grafik (FehlermeldungExtern => "KartenspritesZeichnenGrafik.StadtfeldZeichnen: TexturAccessExtern: null");
         
      else
         Skalierung := TexturenskalierungGrafik.Stadtbewirtschaftung (FeldgrößeExtern     => FeldgrößeExtern,
                                                                      TexturengrößeExtern => TexturenbereichExtern);
         
         DurchsichtigesSpriteZeichnen (SpriteAccessExtern     => SpriteAccess,
                                       PositionExtern         => PositionExtern,
                                       SkalierungExtern       => Skalierung,
                                       DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
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
         Skalierung := TexturenskalierungGrafik.Stadtkarte (SpriteAccessExtern  => SpriteAccess,
                                                            TextureAccessExtern => TexturAccessExtern);
         
         SpritesverwaltungssystemGrafik.PositionSkalierungZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                    PositionExtern     => GrafikRecordKonstanten.Nullposition,
                                                                    SkalierungExtern   => Skalierung);
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
         Skalierung := TexturenskalierungGrafik.TexturskalierungVariabel (SpriteAccessExtern  => SpriteAccess,
                                                                          TextureAccessExtern => TexturAccessExtern,
                                                                          GrößeExtern         => GrößeExtern);
         
         SpritesverwaltungssystemGrafik.PositionSkalierungZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                    PositionExtern     => PositionExtern,
                                                                    SkalierungExtern   => Skalierung);
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
   
   
   
   procedure DurchsichtigesSpriteZeichnenNeu
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      PositionExtern : in Sf.System.Vector2.sfVector2f;
      SkalierungExtern : in Sf.System.Vector2.sfVector2f;
      DurchsichtigkeitExtern : in Sf.sfUint8)
   is begin
      
      SpritesverwaltungssystemGrafik.SetzenBereichPositionSkalieren (SpriteAccessExtern  => SpriteAccess,
                                                                     TexturExtern        => TexturAccessExtern,
                                                                     BereichExtern       => TexturbereichExtern,
                                                                     PositionExtern      => PositionExtern,
                                                                     SkalierungExtern    => SkalierungExtern);
      
      Farbe := Sf.Graphics.Sprite.getColor (sprite => SpriteAccess);
      
      Farbe.a := DurchsichtigkeitExtern;
      
      SpritesverwaltungssystemGrafik.FarbeZeichnen (SpriteAccessExtern => SpriteAccess,
                                                    FarbeExtern        => Farbe);
      
   end DurchsichtigesSpriteZeichnenNeu;

end KartenspritesZeichnenGrafik;
