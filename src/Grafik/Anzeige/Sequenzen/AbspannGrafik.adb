with Sf.Graphics.RenderWindow;
with Sf.Graphics.Text;

with Views;
with TextaccessVariablen;
-- with Spieltexte;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;

package body AbspannGrafik is

   procedure Abspann
     (AbspannExtern : in GrafikDatentypen.Abspann_Enum;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
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
            
         when GrafikDatentypen.Gewonnen_Enum =>
            HintergrundGrafik.Rassenhintergrund (RasseExtern       => RasseExtern,
                                                 HintergrundExtern => AbspannExtern,
                                                 AbmessungenExtern => Viewfläche);
            
            Viewfläche := Gewonnen (ViewflächeExtern => Viewfläche);
      end case;
      
   end Abspann;
   
   
   
   function AllgemeinerText
     return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstandVariabel;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      AllgemeinSchleife:
      for AllgemeinSchleifenwert in TextaccessVariablen.OutroAccess'First .. AllgemeineTextzeilen loop
         
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                       position => Textposition);
         
         Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                                             TextbreiteExtern => Textbreite);
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         TextAccessExtern => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel);
      
         Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert),
                                       position => Textposition);
        
         Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                            text         => TextaccessVariablen.OutroAccess (AllgemeinSchleifenwert));
         
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
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => 0.00);
      Textposition.y := NeueViewfläche.y;
      Textbreite := NeueViewfläche.x;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
        
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
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
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.TextAccess,
                                                                          TextbreiteExtern => 0.00);
      Textposition.y := NeueViewfläche.y;
      Textbreite := NeueViewfläche.x;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.TextAccess,
                                    position => Textposition);
        
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.TextAccess);
      
      return (Textbreite, Textposition.y);
      
   end Gewonnen;

end AbspannGrafik;
