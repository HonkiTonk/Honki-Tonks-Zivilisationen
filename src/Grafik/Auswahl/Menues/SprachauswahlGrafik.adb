with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics.Font;

with GrafikDatentypen;
with InteraktionAuswahl;
with TextaccessVariablen;
with Views;
with GrafikKonstanten;
with ViewKonstanten;

with LeseGrafiktask;

with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TexteinstellungenGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with KonvexverwaltungssystemGrafik;
with TextfarbeGrafik;
with SprachauswahlLogik;

package body SprachauswahlGrafik is
   
   procedure Sprachauswahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.SprachenTexturenMusikSoundbereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      -- Diese Werte später in die Prozedur übergeben, außer die Sprachen? äöü
      -- Gilt auch für die Spielstandauswahl. äöü
      MehrereSeitenVorhanden := LeseGrafiktask.Seitenauswahl;
      AktuelleAuswahl := LeseGrafiktask.Erstauswahl;
      Ende := LeseGrafiktask.Endauswahl;
      AktuelleSprachen := SprachauswahlLogik.AktuelleSprachen;
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      
      AktuelleTextbreite := GrafikKonstanten.Nullwert;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in AktuelleSprachen'Range loop
         
         AktuelleTextFarbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => ZeileSchleifenwert,
                                                                     AuswahlExtern    => AktuelleAuswahl);
         
         if
           MehrereSeitenVorhanden = False
           or
             (MehrereSeitenVorhanden
              and
                ZeileSchleifenwert < Ende)
         then
            NeuerPfad := To_Unbounded_String (Source => TexteinstellungenGrafik.EigeneSchriftartVerwenden (SpracheExtern => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))));
            
            if
              NeuerPfad /= AktuellerPfad
            then
               AktuellerPfad := NeuerPfad;
               -- Muss imemr erst destroyed werden da es sonst bei der Verwendung mehrerer Fonts zu einem Speicherleck kommt.
               Sf.Graphics.Font.destroy (font => SchriftartAccess);
               SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => To_String (Source => AktuellerPfad));
               Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                         font => SchriftartAccess);
               
            else
               null;
            end if;
            
            TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                TextExtern       => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)),
                                                                FarbeExtern      => AktuelleTextFarbe);
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    ViewbreiteExtern => Viewfläche.x);
            
            TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                       PositionExtern   => Textposition);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    TextbreiteExtern => GrafikKonstanten.Nullwert);
            
            InteraktionAuswahl.PositionenSetauswahl (ZeileSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SprachauswahlAccess);
                        
         elsif
           MehrereSeitenVorhanden
           and
             ZeileSchleifenwert = AktuelleSprachen'Last
         then
            Textposition.y := Textposition.y + 3.00 * TextberechnungenHoeheGrafik.Zeilenabstand;
            
            KonvexverwaltungssystemGrafik.PfeilErstellen (PfeilaccessExtern => PfeilAccess);
            
            Textposition.x := Viewfläche.x / GrafikKonstanten.Halbierung - Sf.Graphics.ConvexShape.getLocalBounds (shape => PfeilAccess).width / GrafikKonstanten.Halbierung;
            
            AktuelleTextFarbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Ende,
                                                                        AuswahlExtern    => AktuelleAuswahl);
            
            KonvexverwaltungssystemGrafik.PositionFarbeZeichnen (KonvexaccessExtern => PfeilAccess,
                                                                 PositionExtern     => Textposition,
                                                                 FarbeExtern        => AktuelleTextFarbe);
            
            InteraktionAuswahl.PositionenSetauswahl (Ende) := Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.Spaltenabstand + Sf.Graphics.ConvexShape.getLocalBounds (shape => PfeilAccess).width;
            
         else
            NeueTextbreite := GrafikKonstanten.Nullwert;
         end if;
         
         if
           NeueTextbreite > AktuelleTextbreite
         then
            AktuelleTextbreite := NeueTextbreite;
            
         else
            null;
         end if;
                 
         Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.Zeilenabstand);
         
      end loop AnzeigeSchleife;
            
      Viewfläche := (AktuelleTextbreite, Textposition.y);
      
   end Sprachauswahl;

end SprachauswahlGrafik;
