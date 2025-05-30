with Sf.Graphics.Text;

with Views;
with TextaccessVariablen;
with GrafikKonstanten;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body AbspannGrafik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Hintergrund_Outro_Enum;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      case
        SpeziesExtern
      is
         when others =>
            null;
      end case;
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => Viewfläche,
                                                                                         VerhältnisExtern => (GrafikRecordKonstanten.Sequenzbereich.width,
                                                                                                               GrafikRecordKonstanten.Sequenzbereich.height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.AbspannviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Sequenzbereich);
      
      case
        AbspannExtern
      is
         when GrafikDatentypen.Planetenvernichtung_Enum =>
            HintergrundGrafik.Aufteilung (HintergrundExtern => AbspannExtern,
                                          AbmessungenExtern => Viewfläche);
            
            Viewfläche.y := PlanetVernichtet (MaximaleTextbreiteExtern => Viewfläche.x);
            
         when GrafikDatentypen.Gewonnen_Enum | GrafikDatentypen.Verloren_Enum =>
            HintergrundGrafik.Aufteilung (HintergrundExtern => AbspannExtern,
                                          AbmessungenExtern => Viewfläche);
            
            Viewfläche.y := Gewonnen (MaximaleTextbreiteExtern => Viewfläche.x);
            
         when GrafikDatentypen.Leer_Enum =>
            -- Hier noch eine Warnung einbauen? äöü
            null;
      end case;
      
   end Abspann;
   
   
   
   function AllgemeinerText
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      Textbreite := MaximaleTextbreiteExtern;
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      AllgemeinSchleife:
      for AllgemeinSchleifenwert in TextaccessVariablen.OutroAccess'First .. AllgemeineTextzeilen loop
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
         TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                                    PositionExtern   => Textposition);
         
      end loop AllgemeinSchleife;
      
      return Textposition.y;
      
   end AllgemeinerText;
     
   
   
   function PlanetVernichtet
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      NeueViewfläche.y := AllgemeinerText (MaximaleTextbreiteExtern => MaximaleTextbreiteExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.OutroAccess (1),
                                         str  => "oO");
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.OutroAccess (1),
                                                                              ViewbreiteExtern => MaximaleTextbreiteExtern);
      Textposition.y := NeueViewfläche.y;
      Textbreite := NeueViewfläche.x;
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.OutroAccess (1),
                                                                 PositionExtern   => Textposition);
      
      return Textposition.y;
      
   end PlanetVernichtet;
   
   
   
   function Gewonnen
     (MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
      
      NeueViewfläche.y := AllgemeinerText (MaximaleTextbreiteExtern => MaximaleTextbreiteExtern);
      
      Sf.Graphics.Text.setUnicodeString (text => TextaccessVariablen.OutroAccess (1),
                                         str  => "\o/");
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.OutroAccess (1),
                                                                              ViewbreiteExtern => MaximaleTextbreiteExtern);
      Textposition.y := NeueViewfläche.y;
      Textbreite := NeueViewfläche.x;
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.OutroAccess (1),
                                                                 PositionExtern   => Textposition);
      
      return Textposition.y;
      
   end Gewonnen;

end AbspannGrafik;
