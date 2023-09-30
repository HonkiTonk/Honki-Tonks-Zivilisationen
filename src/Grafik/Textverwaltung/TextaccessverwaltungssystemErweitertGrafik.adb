with GrafikRecordKonstanten;

with TextaccessverwaltungssystemEinfachGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextskalierungGrafik;

package body TextaccessverwaltungssystemErweitertGrafik is

   function TextSkalierenZeichnung
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      TextaccessverwaltungssystemEinfachGrafik.TextPosition (TextaccessExtern => TextAccessExtern,
                                                             TextExtern       => TextExtern,
                                                             PositionExtern   => TextpositionExtern);
         
      Textbreite := TextberechnungenBreiteGrafik.TextbreiteAnfangsabstand (TextAccessExtern => TextAccessExtern,
                                                                           AbstandExtern    => 2.00 * TextberechnungenBreiteGrafik.KleinerSpaltenabstand);
            
      Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                          ErlaubteBreiteExtern => MaximaleTextbreiteExtern);
      Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
                        
      TextaccessverwaltungssystemEinfachGrafik.SkalierenZeichnen (TextaccessExtern => TextAccessExtern,
                                                                  SkalierungExtern => Skalierung);
      
      return TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => TextpositionExtern.y,
                                                           ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end TextSkalierenZeichnung;
   
   
   
   function TextSkalierenMittelnZeichnen
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      TextaccessverwaltungssystemEinfachGrafik.Text (TextaccessExtern => TextAccessExtern,
                                                     TextExtern       => TextExtern);
      
      XTextposition := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextAccessExtern,
                                                                             ViewbreiteExtern => MaximaleTextbreiteExtern);
      
      if
        XTextposition > MaximaleTextbreiteExtern / 2.00
      then
         TextaccessverwaltungssystemEinfachGrafik.TextPosition (TextaccessExtern => TextAccessExtern,
                                                                TextExtern       => TextExtern,
                                                                PositionExtern   => TextpositionExtern);
         
      else
         TextaccessverwaltungssystemEinfachGrafik.TextPosition (TextaccessExtern => TextAccessExtern,
                                                                TextExtern       => TextExtern,
                                                                PositionExtern   => (XTextposition, TextpositionExtern.y));
      end if;
      
      Textbreite := TextberechnungenBreiteGrafik.TextbreiteAnfangsabstand (TextAccessExtern => TextAccessExtern,
                                                                           AbstandExtern    => 2.00 * TextberechnungenBreiteGrafik.KleinerSpaltenabstand);
            
      Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                          ErlaubteBreiteExtern => MaximaleTextbreiteExtern);
      Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
                        
      TextaccessverwaltungssystemEinfachGrafik.SkalierenZeichnen (TextaccessExtern => TextAccessExtern,
                                                                  SkalierungExtern => Skalierung);
      
      return TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => TextpositionExtern.y,
                                                           ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
   end TextSkalierenMittelnZeichnen;

end TextaccessverwaltungssystemErweitertGrafik;
