with GrafikRecordKonstanten;
with GrafikKonstanten;

with TexturenskalierungGrafik;
with MeldungssystemHTSEB;
with SpritesverwaltungssystemGrafik;

package body KartenspritesZeichnenGrafik is
   
   procedure KartenfeldZeichnen
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
         MeldungssystemHTSEB.Grafik (MeldungExtern => "KartenspritesZeichnenGrafik.KartenfeldZeichnen: TexturAccessExtern: null");
         
      else
         Skalierung := TexturenskalierungGrafik.Kartenfeldskalierung (TexturengrößeExtern => (Sf.sfUint32 (TexturbereichExtern.width), Sf.sfUint32 (TexturbereichExtern.height)));
         
         SpriteZeichnen (TexturAccessExtern     => TexturAccessExtern,
                         TexturbereichExtern    => TexturbereichExtern,
                         PositionExtern         => PositionExtern,
                         SkalierungExtern       => Skalierung,
                         DurchsichtigkeitExtern => DurchsichtigkeitExtern);
      end if;
      
   end KartenfeldZeichnen;
   
   
   
   procedure StadtbewirtschaftungZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturbereichExtern : in Sf.Graphics.Rect.sfIntRect;
      FeldgrößeExtern : in Sf.System.Vector2.sfVector2f;
      PositionExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         MeldungssystemHTSEB.Grafik (MeldungExtern => "KartenspritesZeichnenGrafik.StadtfeldZeichnen: TexturAccessExtern: null");
         
      else
         Skalierung := TexturenskalierungGrafik.Stadtbewirtschaftung (FeldgrößeExtern     => FeldgrößeExtern,
                                                                      TexturengrößeExtern => (Float (TexturbereichExtern.width), Float (TexturbereichExtern.height)));
         
         SpriteZeichnen (TexturAccessExtern     => TexturAccessExtern,
                         TexturbereichExtern    => TexturbereichExtern,
                         PositionExtern         => PositionExtern,
                         SkalierungExtern       => Skalierung,
                         DurchsichtigkeitExtern => GrafikKonstanten.Undurchsichtig);
      end if;
      
   end StadtbewirtschaftungZeichnen;
   
   
   
   procedure StadtkarteZeichnen
     (TexturAccessExtern : in Sf.Graphics.sfTexture_Ptr;
      TexturenbereichExtern : in Sf.System.Vector2.sfVector2f)
   is
      use type Sf.Graphics.sfTexture_Ptr;
   begin
      
      if
        TexturAccessExtern = null
      then
         MeldungssystemHTSEB.Grafik (MeldungExtern => "KartenspritesZeichnenGrafik.StadtkarteZeichnen: TexturAccessExtern: null");
         
      else
         Skalierung := TexturenskalierungGrafik.Vollbildskalierung (TexturengrößeExtern => (Sf.sfUint32 (TexturenbereichExtern.x), Sf.sfUint32 (TexturenbereichExtern.y)));
         
         SpritesverwaltungssystemGrafik.PositionSkalierungZeichnen (SpriteAccessExtern => SpriteAccess,
                                                                    PositionExtern     => GrafikRecordKonstanten.Nullposition,
                                                                    SkalierungExtern   => Skalierung);
      end if;
      
   end StadtkarteZeichnen;
   
   
   
   procedure SpriteZeichnen
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
      
   end SpriteZeichnen;

end KartenspritesZeichnenGrafik;
