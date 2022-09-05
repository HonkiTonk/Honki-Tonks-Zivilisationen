pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.Graphics.Text;
with Sf.Graphics.RenderWindow;

with Views;
with TextaccessVariablen;
with GrafikDatentypen;

with LeseWichtiges;

with Warnung;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with EinstellungenGrafik;
with TextberechnungenBreiteGrafik;
with TexteinstellungenGrafik;
with HintergrundGrafik;

package body ForschungserfolgGrafik is

   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Natural)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungserfolgviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungserfolgbereich);
      
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
            Warnung.GrafikWarnung (WarnmeldungExtern => "ForschungserfolgGrafik.Forschungserfolg - Falscher Auswahlbereich.");
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
   end Forschungserfolg;
   
   
   
   function Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := 0.00;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      Sf.Graphics.Text.setPosition (text     => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern),
                                    position => Textposition);
      
      Sf.Graphics.Text.setColor (text  => TextaccessVariablen.ForschungsmenüAccess (RasseExtern, TechnologieExtern),
                                 color => TexteinstellungenGrafik.Schriftfarben.FarbeStandardText);
      
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
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
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
