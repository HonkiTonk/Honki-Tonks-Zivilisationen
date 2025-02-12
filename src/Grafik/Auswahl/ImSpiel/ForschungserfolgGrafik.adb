with Views;
with TextaccessVariablen;
with GrafikDatentypen;
with ViewKonstanten;
with GrafikKonstanten;
with ForschungKonstanten;

with LeseWichtiges;

with MeldungssystemHTSEB;
with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemEinfachGrafik;

package body ForschungserfolgGrafik is

   procedure Forschungserfolg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AuswahlExtern : in Natural)
   is begin
      
      -- Das hier nach Grafik auslagern und mit übergeben? äöü
      Forschungprojekt := LeseWichtiges.Forschungsprojekt (SpeziesExtern => SpeziesExtern);
      
      case
        Forschungprojekt
      is
         when ForschungKonstanten.LeerForschung =>
            return;
            
         when others =>
            Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
            ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.ForschungsviewAccesse (ViewKonstanten.ForschungsmenüErfolg),
                                                  GrößeExtern          => Viewfläche,
                                                  AnzeigebereichExtern => GrafikRecordKonstanten.Forschungsbereich (ViewKonstanten.ForschungsmenüErfolg));
      
            HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Forschungserfolg_Enum,
                                          AbmessungenExtern => Viewfläche);
      end case;
      
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
            MeldungssystemHTSEB.Grafik (MeldungExtern => "ForschungserfolgGrafik.Forschungserfolg: Auswahlbereich: " & AuswahlExtern'Wide_Wide_Image);
      end case;
      
      Viewfläche.y := Viewfläche.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
   end Forschungserfolg;
   
   
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDVorhanden;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, TechnologieExtern),
                                                               PositionExtern   => Textposition,
                                                               FarbeExtern      => TextfarbeGrafik.Standardfarbe);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, TechnologieExtern),
                                                                              ViewbreiteExtern => ViewbreiteExtern);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüAccess (SpeziesExtern, TechnologieExtern),
                                                                          TextbreiteExtern => Textbreite);
      
      return (Textbreite, Textposition.y);
      
   end Forschung;
     
     
     
   function Infotext
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungIDVorhanden;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
   is begin
      
      Textbreite := GrafikKonstanten.Nullwert;
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      
      TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, TechnologieExtern),
                                                          PositionExtern   => Textposition);
      
      Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, TechnologieExtern),
                                                                              ViewbreiteExtern => ViewbreiteExtern);
      
      Textbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.ForschungsmenüZusatztextAccess (SpeziesExtern, TechnologieExtern),
                                                                          TextbreiteExtern => Textbreite);
      
      return (Textbreite, Textposition.y);
      
   end Infotext;

end ForschungserfolgGrafik;
