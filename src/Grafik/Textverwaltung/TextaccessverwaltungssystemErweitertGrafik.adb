with GrafikRecordKonstanten;

with TextaccessverwaltungssystemEinfachGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextskalierungGrafik;

package body TextaccessverwaltungssystemErweitertGrafik is
   
   function TextSkalierenFarbeZeichnen
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr;
      FarbeExtern : in Sf.Graphics.Color.sfColor)
      return Float
   is begin
      
      TextaccessverwaltungssystemEinfachGrafik.Farbe (TextaccessExtern => TextAccessExtern,
                                                      FarbeExtern      => FarbeExtern);
      
      return TextSkalierenZeichnen (TextExtern               => TextExtern,
                                    TextpositionExtern       => TextpositionExtern,
                                    MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                    TextAccessExtern         => TextAccessExtern);
      
   end TextSkalierenFarbeZeichnen;
   
   

   function TextSkalierenZeichnen
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
                                                           ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end TextSkalierenZeichnen;
   
   
   
   function TextSkalierenMittelnZeichnen
     (TextExtern : in Wide_Wide_String;
      TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      TextaccessverwaltungssystemEinfachGrafik.Text (TextaccessExtern => TextAccessExtern,
                                                     TextExtern       => TextExtern);
      
      return SkalierenMittelnZeichnen (TextpositionExtern       => TextpositionExtern,
                                       MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                       TextAccessExtern         => TextAccessExtern);
      
   end TextSkalierenMittelnZeichnen;
   
   
   
   function SkalierenMittelnZeichnen
     (TextpositionExtern : in Sf.System.Vector2.sfVector2f;
      MaximaleTextbreiteExtern : in Float;
      TextAccessExtern : in Sf.Graphics.sfText_Ptr)
      return Float
   is begin
      
      Textbreite := TextberechnungenBreiteGrafik.TextbreiteAnfangsabstand (TextAccessExtern => TextAccessExtern,
                                                                           AbstandExtern    => 2.00 * TextberechnungenBreiteGrafik.KleinerSpaltenabstand);
      
      if
        Textbreite >= MaximaleTextbreiteExtern
      then
         Skalierung.x := TextskalierungGrafik.Verkleinerung (AktuelleBreiteExtern => Textbreite,
                                                             ErlaubteBreiteExtern => MaximaleTextbreiteExtern);
         Skalierung.y := GrafikRecordKonstanten.Standardskalierung.y;
         
         TextaccessverwaltungssystemEinfachGrafik.Position (TextaccessExtern => TextAccessExtern,
                                                            PositionExtern   => TextpositionExtern);
         
      else
         Skalierung := GrafikRecordKonstanten.Standardskalierung;
         XTextposition := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextAccessExtern,
                                                                                ViewbreiteExtern => MaximaleTextbreiteExtern);
         
         TextaccessverwaltungssystemEinfachGrafik.Position (TextaccessExtern => TextAccessExtern,
                                                            PositionExtern   => (XTextposition, TextpositionExtern.y));
      end if;
            
                        
      TextaccessverwaltungssystemEinfachGrafik.SkalierenZeichnen (TextaccessExtern => TextAccessExtern,
                                                                  SkalierungExtern => Skalierung);
      
      return TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => TextpositionExtern.y,
                                                           ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end SkalierenMittelnZeichnen;

end TextaccessverwaltungssystemErweitertGrafik;
