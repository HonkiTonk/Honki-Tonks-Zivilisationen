with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with ViewKonstanten;

with LeseWichtiges;

with Fehlermeldungssystem;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with HintergrundGrafik;

package body ForschungserfolgGrafik is

   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Natural)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüErfolg),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErfolg));
      
      HintergrundGrafik.Rassenhintergrund (RasseExtern       => RasseExtern,
                                           HintergrundExtern => GrafikDatentypen.Forschungserfolg_Enum,
                                           AbmessungenExtern => Viewfläche);
      
      Forschungprojekt := LeseWichtiges.Forschungsprojekt (RasseExtern => RasseExtern);
      
      case
        AuswahlExtern
      is
         when 1 =>
            Viewfläche := Forschung (RasseExtern       => RasseExtern,
                                      TechnologieExtern => Forschungprojekt,
                                      ViewbreiteExtern  => Viewfläche.x);
            
         when 2 =>
            Viewfläche := Infotext (RasseExtern       => RasseExtern,
                                     TechnologieExtern => Forschungprojekt,
                                     ViewbreiteExtern  => Viewfläche.x);
            
         when others =>
            Fehlermeldungssystem.Grafik (FehlermeldungExtern => "ForschungserfolgGrafik.Forschungserfolg: Auswahlbereich: " & AuswahlExtern'Wide_Wide_Image);
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
   end Forschungserfolg;
   
   
   
   function Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern),
                                    position => Textposition);
      
      TextfarbeGrafik.Standardfarbe (TextaccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern));
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern),
                                                                              ViewbreiteExtern => ViewbreiteExtern);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern),
                                                                          TextbreiteExtern => Textbreite);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern));
      
      return (Textbreite, Textposition.y);
      
   end Forschung;
     
     
     
   function Infotext
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, TechnologieExtern),
                                    position => Textposition);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, TechnologieExtern),
                                                                              ViewbreiteExtern => ViewbreiteExtern);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, TechnologieExtern),
                                                                          TextbreiteExtern => Textbreite);
      
      Sf.Graphics.RenderWindow.drawText (renderWindow => EinstellungenGrafik.FensterAccess,
                                         text         => TextaccessVariablen.ForschungsmenüZusatztextAccess (RasseExtern, TechnologieExtern));
      
      return (Textbreite, Textposition.y);
      
   end Infotext;

end ForschungserfolgGrafik;
