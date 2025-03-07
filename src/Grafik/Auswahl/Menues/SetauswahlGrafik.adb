with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;
with Sf.Graphics.Font;

with Views;
with ViewKonstanten;
with GrafikKonstanten;
with GrafikDatentypen;
with InteraktionAuswahl;
with TextaccessVariablen;

with LeseGrafiktask;

with ViewsEinstellenGrafik;
with TextberechnungenHoeheGrafik;
with HintergrundGrafik;
with SetauswahlLogik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextberechnungenBreiteGrafik;
with KonvexverwaltungssystemGrafik;
with TexteinstellungenGrafik;

package body SetauswahlGrafik is

   procedure Setauswahl
     (SpracheExtern : in Boolean)
   is begin
      
      Viewfläche := ViewsEinstellenGrafik.ViewflächeAuflösungAnpassen (ViewflächeExtern => Viewfläche);
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.MenüviewAccesse (ViewKonstanten.MenüAuswahl),
                                            GrößeExtern          => Viewfläche,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Setbereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => Viewfläche);
      
      -- Diese Werte später in die Prozedur übergeben, außer die Sprachen? äöü
      -- Gilt auch für die Spielstandauswahl. äöü
      MehrereSeitenVorhanden := LeseGrafiktask.Seitenauswahl;
      AktuelleAuswahl := LeseGrafiktask.Erstauswahl;
      Ende := LeseGrafiktask.Endauswahl;
      Auswahlmöglichkeiten := SetauswahlLogik.Auswahlmöglichkeiten;
      
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      
      AktuelleTextbreite := GrafikKonstanten.Nullwert;
      
      AnzeigeSchleife:
      for ZeileSchleifenwert in Auswahlmöglichkeiten'Range loop
         
         AktuelleTextFarbe := TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => ZeileSchleifenwert,
                                                                     AuswahlExtern    => AktuelleAuswahl);
         
         if
           MehrereSeitenVorhanden = False
           or
             (MehrereSeitenVorhanden
              and
                ZeileSchleifenwert < Ende)
         then
            case
              SpracheExtern
            is
               when True =>
                  NeuerPfad := To_Unbounded_String (Source => TexteinstellungenGrafik.EigeneSchriftartVerwenden (SpracheExtern => To_Wide_Wide_String (Source => Auswahlmöglichkeiten (ZeileSchleifenwert))));
            
                  if
                    NeuerPfad /= AktuellerPfad
                  then
                     AktuellerPfad := NeuerPfad;
                     -- Muss imemr erst destroyed werden da es sonst bei der Verwendung mehrerer Fonts zu einem Speicherleck kommt.
                     Sf.Graphics.Font.destroy (font => SchriftartAccess);
                     SchriftartAccess := Sf.Graphics.Font.createFromFile (filename => To_String (Source => AktuellerPfad));
                     Sf.Graphics.Text.setFont (text => TextaccessVariablen.SetauswahlAccess,
                                               font => SchriftartAccess);
               
                  else
                     null;
                  end if;
                  
               when False =>
                  null;
            end case;
            
            TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.SetauswahlAccess,
                                                                TextExtern       => To_Wide_Wide_String (Source => Auswahlmöglichkeiten (ZeileSchleifenwert)),
                                                                FarbeExtern      => AktuelleTextFarbe);
            
            Textposition.x := TextberechnungenBreiteGrafik.MittelpositionBerechnen (TextAccessExtern => TextaccessVariablen.SetauswahlAccess,
                                                                                    ViewbreiteExtern => Viewfläche.x);
            
            TextaccessverwaltungssystemEinfachGrafik.PositionZeichnen (TextaccessExtern => TextaccessVariablen.SetauswahlAccess,
                                                                       PositionExtern   => Textposition);
            
            NeueTextbreite := TextberechnungenBreiteGrafik.NeueTextbreiteErmitteln (TextAccessExtern => TextaccessVariablen.SetauswahlAccess,
                                                                                    TextbreiteExtern => GrafikKonstanten.Nullwert);
            
            InteraktionAuswahl.PositionenSetauswahl (ZeileSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SetauswahlAccess);
                        
         elsif
           MehrereSeitenVorhanden
           and
             ZeileSchleifenwert = Auswahlmöglichkeiten'Last
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
      
   end Setauswahl;

end SetauswahlGrafik;
