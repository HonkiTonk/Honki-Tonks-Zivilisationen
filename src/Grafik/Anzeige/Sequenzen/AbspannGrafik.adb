with Sf.Graphics.Text;

with Views;
with TextaccessVariablen;
with GrafikKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemGrafik;

package body AbspannGrafik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Abspannbereich);
      
      case
        AbspannExtern
      is
         when GrafikDatentypen.Planet_Vernichtet_Enum =>
            HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.PZB_Ende_Hintergrund_Enum,
                                           AbmessungenExtern => Viewfläche);
            
            Viewfläche := PlanetVernichtet (ViewflächeExtern => Viewfläche);
            
         when GrafikDatentypen.Gewonnen_Enum | GrafikDatentypen.Verloren_Enum =>
            HintergrundGrafik.Spezieshintergrund (SpeziesExtern     => SpeziesExtern,
                                                  HintergrundExtern => AbspannExtern,
                                                  AbmessungenExtern => Viewfläche);
            
            Viewfläche := Gewonnen (ViewflächeExtern => Viewfläche);
      end case;
      
   end Abspann;
   
   
   
   function AllgemeinerText
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      AllgemeinSchleife:
      for AllgemeinSchleifenwert in TextaccessVariablen.OutroAccess'First .. AllgemeineTextzeilen loop
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
         TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                             PositionExtern   => Textposition);
         
      end loop AllgemeinSchleife;
      
      return (Textbreite, Textposition.y);
      
   end AllgemeinerText;
     
   
   
   
   function PlanetVernichtet
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      NeueViewfläche := AllgemeinerText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => "oO");
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                              ViewbreiteExtern => ViewflächeExtern.x);
      Textposition.y := NeueViewfläche.y;
      Textbreite := NeueViewfläche.x;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                          PositionExtern   => Textposition);
      
      return (Textbreite, Textposition.y);
      
   end PlanetVernichtet;
   
   
   
   function Gewonnen
     (ViewflächeExtern : in Sf.System.Vector2.sfVector2f)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      NeueViewfläche := AllgemeinerText;
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.TextAccess,
                                         str  => "\o/");
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                              ViewbreiteExtern => ViewflächeExtern.x);
      Textposition.y := NeueViewfläche.y;
      Textbreite := NeueViewfläche.x;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.TextAccess,
                                                          PositionExtern   => Textposition);
      
      return (Textbreite, Textposition.y);
      
   end Gewonnen;

end AbspannGrafik;
