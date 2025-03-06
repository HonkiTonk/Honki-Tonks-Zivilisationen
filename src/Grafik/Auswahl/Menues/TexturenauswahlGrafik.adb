with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with Sf.Graphics.Text;

with GrafikDatentypen;
with Views;
with ViewKonstanten;
with GrafikKonstanten;
with InteraktionAuswahl;
with TextaccessVariablen;

with LeseGrafiktask;

with HintergrundGrafik;
with ViewsEinstellenGrafik;
with TexturenauswahlLogik;
with TextberechnungenHoeheGrafik;
with TextfarbeGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with TextberechnungenBreiteGrafik;
with KonvexverwaltungssystemGrafik;

package body TexturenauswahlGrafik is

   procedure Texturenauswahl
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
      Auswahlmöglichkeiten := TexturenauswahlLogik.AktuelleTexturen;
      
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
            TextaccessverwaltungssystemEinfachGrafik.TextFarbe (TextaccessExtern => TextaccessVariablen.SprachauswahlAccess,
                                                                TextExtern       => To_Wide_Wide_String (Source => Auswahlmöglichkeiten (ZeileSchleifenwert)),
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
      
   end Texturenauswahl;

end TexturenauswahlGrafik;
