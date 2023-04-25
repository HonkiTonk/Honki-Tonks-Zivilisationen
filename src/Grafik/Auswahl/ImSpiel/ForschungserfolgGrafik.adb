with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with ViewKonstanten;
with GrafikKonstanten;

with LeseWichtiges;

with Fehlermeldungssystem;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemGrafik;

package body ForschungserfolgGrafik is

   procedure Forschungserfolg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AuswahlExtern : in Natural)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüErfolg),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErfolg));
      
      HintergrundGrafik.Spezieshintergrund (SpeziesExtern     => SpeziesExtern,
                                            HintergrundExtern => GrafikDatentypen.Forschungserfolg_Enum,
                                            AbmessungenExtern => Viewfläche);
      
      Forschungprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        AuswahlExtern
      is
         when 1 =>
            Viewfläche := Forschung (SpeziesExtern     => SpeziesExtern,
                                     TechnologieExtern => Forschungprojekt,
                                     ViewbreiteExtern  => Viewfläche.x);
            
         when 2 =>
            Viewfläche := Infotext (SpeziesExtern     => SpeziesExtern,
                                    TechnologieExtern => Forschungprojekt,
                                    ViewbreiteExtern  => Viewfläche.x);
            
         when others =>
            Fehlermeldungssystem.Grafik (FehlermeldungExtern => "ForschungserfolgGrafik.Forschungserfolg: Auswahlbereich: " & AuswahlExtern'Wide_Wide_Image);
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
   end Forschungserfolg;
   
   
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, TechnologieExtern),
                                                               PositionExtern   => Textposition,
                                                               FarbeExtern      => TextfarbeGrafik.Standardfarbe);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, TechnologieExtern),
                                                                              ViewbreiteExtern => ViewbreiteExtern);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, TechnologieExtern),
                                                                          TextbreiteExtern => Textbreite);
      
      return (Textbreite, Textposition.y);
      
   end Forschung;
     
     
     
   function Infotext
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstandVariabel;
      
      TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, TechnologieExtern),
                                                          PositionExtern   => Textposition);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, TechnologieExtern),
                                                                              ViewbreiteExtern => ViewbreiteExtern);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, TechnologieExtern),
                                                                          TextbreiteExtern => Textbreite);
      
      return (Textbreite, Textposition.y);
      
   end Infotext;

end ForschungserfolgGrafik;
