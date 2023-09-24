with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings; use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Ada.Directories; use Ada.Directories;

with Sf.Graphics.Text;
with Sf.Graphics.Font;

with GrafikDatentypen;
with InteraktionAuswahl;
with TextaccessVariablen;
with Views;
with GrafikKonstanten;
with VerzeichnisKonstanten;
with ViewKonstanten;

with LeseGrafiktask;

with TextberechnungenBreiteGrafik;
with TextberechnungenHoeheGrafik;
with TexteinstellungenGrafik;
with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextaccessverwaltungssystemGrafik;
with KonvexverwaltungssystemGrafik;
with TextfarbeGrafik;
with SprachauswahlLogik;

package body SprachauswahlGrafik is
   
   procedure Sprachauswahl
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Sprachenbereich);
      
      HintergrundGrafik.Hintergrund (HintergrundExtern => GrafikDatentypen.Menü_Hintergrund_Enum,
                                     AbmessungenExtern => Viewfläche);
      
      -- Diese Werte später in die Prozedur übergeben, außer die Sprachen? äöü
      -- Gilt auch für die Spielstandauswahl. äöü
      MehrereSeitenVorhanden := LeseGrafiktask.Seitenauswahl;
      AktuelleAuswahl := LeseGrafiktask.Erstauswahl;
      Ende := LeseGrafiktask.Endauswahl;
      AktuelleSprachen := SprachauswahlLogik.AktuelleSprachen;
      
      Textposition.y := TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
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
            if
              Exists (Name => VerzeichnisKonstanten.SprachenStrich & Encode (Item => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))) & VerzeichnisKonstanten.FontDatei) = False
            then
               NeuerPfad := To_Unbounded_String (Source => TexteinstellungenGrafik.StandardSchriftartVerwenden);
            
            else
               NeuerPfad := To_Unbounded_String (Source => TexteinstellungenGrafik.EigeneSchriftartVerwenden (SpracheExtern => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert))));
            end if;
            
            if
              NeuerPfad /= AktuellerPfad
            then
               AktuellerPfad := NeuerPfad;
               SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => To_String (Source => AktuellerPfad));
               Sf.Graphics.Text.setFont (text => TextaccessVariablen.SprachauswahlAccess,
                                         font => SchriftartAccess);
               
            else
               null;
            end if;
            
            TextaccessverwaltungssystemGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                         TextExtern       => To_Wide_Wide_String (Source => AktuelleSprachen (ZeileSchleifenwert)),
                                                         FarbeExtern      => AktuelleTextFarbe);
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    ViewbreiteExtern => Viewfläche.x);
            
            TextaccessverwaltungssystemGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                PositionExtern   => Textposition);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                                    TextbreiteExtern => GrafikKonstanten.Nullwert);
            
            InteraktionAuswahl.PositionenSprachauswahl (ZeileSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SprachauswahlAccess);
                        
         elsif
           MehrereSeitenVorhanden
           and
             ZeileSchleifenwert = AktuelleSprachen'Last
         then
            Textposition.y := Textposition.y + 3.00 * TextberechnungenHoeheGrafik.ZeilenabstandVariabel;
            
            KonvexverwaltungssystemGrafik.PfeilErstellen (PfeilaccessExtern => PfeilAccess);
            
            Textposition.x := Viewfläche.x / GrafikKonstanten.Halbierung - Sf.Graphics.ConvexShape.getLocalBounds (shape => PfeilAccess).width / GrafikKonstanten.Halbierung;
            
            AktuelleTextFarbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => Ende,
                                                                        AuswahlExtern    => AktuelleAuswahl);
            
            KonvexverwaltungssystemGrafik.PositionFarbeZeichnen (KonvexaccessExtern => PfeilAccess,
                                                                 PositionExtern     => Textposition,
                                                                 FarbeExtern        => AktuelleTextFarbe);
            
            InteraktionAuswahl.PositionenSprachauswahl (Ende) := Sf.Graphics.ConvexShape.getGlobalBounds (shape => PfeilAccess);
            
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
                                                                         ZusatzwertExtern => TextberechnungenHoeheGrafik.ZeilenabstandVariabel);
         
      end loop AnzeigeSchleife;
            
      Viewfläche := (AktuelleTextbreite, Textposition.y);
      
   end Sprachauswahl;

end SprachauswahlGrafik;
