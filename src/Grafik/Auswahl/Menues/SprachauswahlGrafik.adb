with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with GrafikDatentypen;
with InteraktionAuswahl;
with TextaccessVariablen;
with Views;

with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TexteinstellungenGrafik;
with NachGrafiktask;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemGrafik;
with KonvexverwaltungssystemGrafik;

package body SprachauswahlGrafik is
   
   procedure Sprachauswahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccess,
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Sprachenbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      case
        Erstaufruf
      is
         when True =>
            Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                      font => TexteinstellungenGrafik.SchriftartAccess);
            Erstaufruf := False;
            
         when False =>
            null;
      end case;
      
      -- Diese Werte später in die Prozedur übergeben, außer die Sprachen? äöü
      -- Gilt auch für die Spielstandauswahl. äöü
      MehrereSeiten := NachGrafiktask.MehrereSeiten;
      AktuelleAuswahl := NachGrafiktask.AktuelleAuswahl.AuswahlEins;
      Ende := NachGrafiktask.Endauswahl;
      AktuelleSprachen := SprachauswahlLogik.AktuelleSprachen;
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
      AktuelleTextbreite := 0.00;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'Range loop
         
         if
           AktuelleAuswahl = ZeileSchleifenwert
         then
            AktuelleTextFarbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
            
         else
            AktuelleTextFarbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
         end if;
         
         if
           MehrereSeiten = False
           or
             (MehrereSeiten
              and
                ZeileSchleifenwert < Ende)
         then
            TextaccessverwaltungssystemGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                         TextExtern       => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)),
                                                         FarbeExtern      => AktuelleTextFarbe);
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    ViewbreiteExtern => Viewfläche.x);
            
            TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                PositionExtern   => Textposition);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    TextbreiteExtern => 0.00);
            
            InteraktionAuswahl.PositionenSprachauswahl (ZeileSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SprachauswahlAccess);
                        
         elsif
           MehrereSeiten
           and
             ZeileSchleifenwert = AktuelleSprachen'Last
         then
            Textposition.y := Textposition.y + 3.00 * TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
            
            KonvexverwaltungssystemGrafik.PfeilErstellen (PfeilaccessExtern => PfeilAccess);
            
            Textposition.x := Viewfläche.x / 2.00 - 0.50 * Sf.Graphics.ConvexShape.getLocalBounds (shape => PfeilAccess).width;
            
            if
              AktuelleAuswahl = Ende
            then
               AktuelleTextFarbe := TexteinstellungenGrafik.Schriftfarben.FarbeAusgewähltText;
                  
            else
               AktuelleTextFarbe := TexteinstellungenGrafik.Schriftfarben.FarbeStandardText;
            end if;
            
            KonvexverwaltungssystemGrafik.PositionFarbeZeichnen (KonvexaccessExtern => PfeilAccess,
                                                                 PositionExtern     => Textposition,
                                                                 FarbeExtern        => AktuelleTextFarbe);
            
            InteraktionAuswahl.PositionenSprachauswahl (Ende) := Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.SpaltenabstandVariabel + Sf.Graphics.ConvexShape.getLocalBounds (shape => PfeilAccess).width;
            
         else
            NeueTextbreite := 0.00;
         end if;
         
         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;
            
         else
            null;
         end if;
                 
         Textposition.y := TextberechnungenHoeheGrafik.KonstanteTextposition (PositionExtern   => Textposition.y,
                                                                              ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
      end loop AnzeigeSchleife;
            
      Viewfläche := (AktuelleTextbreite, Textposition.y);
      
   end Sprachauswahl;

end SprachauswahlGrafik;
