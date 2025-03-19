with Sf.Graphics.Text;

with MeldungssystemHTSEB;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with TextKonstanten;
with TastenbelegungKonstanten;
with Menuetexte;
with BefehleDatentypen;
with ViewKonstanten;
with TextDatentypen;
with GrafikKonstanten;

with LeseTastenbelegungDatenbank;

with ViewsEinstellenGrafik;
with HintergrundGrafik;
with TextberechnungenHoeheGrafik;
with TextberechnungenBreiteGrafik;
with TextfarbeGrafik;
with TexteinstellungenGrafik;
with TextaccessverwaltungssystemEinfachGrafik;
with SteuerungsauswahlLogik;
with TextaccessverwaltungssystemErweitertGrafik;
with FensterGrafik;

with DiagnosesystemZusatzinformationen;
with DiagnosesystemHTSEB;

package body SteuerungsmenueGrafik is

   procedure Steuerungsmenü
     (AuswahlExtern : in SystemRecords.DoppelauswahlRecord)
   is begin
      
      -- Die verschiedenen Reiter oben.
      ViewflächeAufteilung := ViewsEinstellenGrafik.ViewflächeVariabelAnpassen (ViewflächeExtern => ViewflächeAufteilung,
                                                                                  VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungKategorie).width,
                                                                                                        GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungKategorie).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungKategorie),
                                            GrößeExtern          => ViewflächeAufteilung,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungKategorie));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => ViewflächeAufteilung);
                  
      ViewflächeAufteilung := Steuerungsaufteilung (AuswahlExtern         => AuswahlExtern.Erstauswahl,
                                                     WelcheSteuerungExtern => SteuerungsauswahlLogik.WelcheSteuerung);
      
      
      
      -- Die Tastenbelegung.
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeBelegung,
                                                                                                 VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungAuswahl).width,
                                                                                                                       GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungAuswahl).height));
      
      Anzeigebereich := GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungAuswahl);
      
      -- Nicht der Anzeigestart muss geändert werden, sondern ich muss move verwenden, vermutlich. äöü
      
      DiagnosesystemHTSEB.Zahl (AuswahlExtern.Zweitauswahl);
      
      case
        AuswahlExtern.Zweitauswahl
      is
         when InteraktionAuswahl.PositionenSteuerungsleiste'Range =>
            Bewegung.y := (Float (AuswahlExtern.Zweitauswahl) - 1.00) * 100.00;
            
         when others =>
            null;
      end case;
      
      AktuelleAuflösungshöhe := FensterGrafik.AktuelleAuflösung.y;
      
      if
        ViewflächeBelegung.y > AktuelleAuflösungshöhe
      then
         Anzeigebereich.height := ViewflächeBelegung.y / AktuelleAuflösungshöhe;
         
      else
         null;
      end if;
      
      ViewsEinstellenGrafik.ViewEinstellenBewegen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungAuswahl),
                                                   GrößeExtern          => ViewflächeBelegung,
                                                   BewegungExtern       => Bewegung,
                                                   AnzeigebereichExtern => Anzeigebereich);
      
      -- ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungAuswahl),
      --                                       GrößeExtern          => ViewflächeBelegung,
      --                                       AnzeigebereichExtern => Anzeigebereich);
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => ViewflächeBelegung);
      
      ViewflächeBelegung.y := Steuerung (AuswahlExtern            => AuswahlExtern.Erstauswahl,
                                          WelcheSteuerungExtern    => SteuerungsauswahlLogik.WelcheSteuerung,
                                          MaximaleTextbreiteExtern => ViewflächeBelegung.x);
      
      
      
      -- Zum Scrollen.
      Scrollen (BelegungslängeExtern => ViewflächeBelegung.y);
                  
   end Steuerungsmenü;
   
   
   
   function Steuerungsaufteilung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum)
      return Sf.System.Vector2.sfVector2f
   is
      use type TastenbelegungDatentypen.Tastenbelegungskategorie_Enum;
   begin
      
      Textposition.y := TextberechnungenHoeheGrafik.KleinerZeilenabstand;
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand;
      
      AufteilungSchleife:
      for AufteilungSchleifenwert in AufteilungArray'Range loop
         
         if
           AuswahlExtern = -AufteilungSchleifenwert
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Ausgewählt_Enum);
         
         elsif
           WelcheSteuerungExtern = TastenbelegungDatentypen.Allgemeinbelegung_Enum
           and
             AufteilungSchleifenwert = 1
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
            
         elsif
           WelcheSteuerungExtern = TastenbelegungDatentypen.Einheitenbelegung_Enum
           and
             AufteilungSchleifenwert = 2
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
            
         elsif
           WelcheSteuerungExtern = TastenbelegungDatentypen.Stadtbelegung_Enum
           and
             AufteilungSchleifenwert = 3
         then
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Aktiver_Menübereich_Enum);
           
         else
            Farbe := TexteinstellungenGrafik.SchriftfarbeLesen (WelcheFarbeExtern => TextDatentypen.Standard_Enum);
         end if;
         
         TextaccessverwaltungssystemEinfachGrafik.PositionFarbeZeichnen (TextaccessExtern => TextaccessVariablen.SteuerungAccess (Aufteilung (AufteilungSchleifenwert)),
                                                                         PositionExtern   => Textposition,
                                                                         FarbeExtern      => Farbe);
         
         InteraktionAuswahl.PositionenSteuerungsaufteilung (AufteilungSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungAccess (Aufteilung (AufteilungSchleifenwert)));
      
         Textposition.x := Textposition.x + Sf.Graphics.Text.getLocalBounds (text => TextaccessVariablen.SteuerungAccess (Aufteilung (AufteilungSchleifenwert))).width
           + GrafikKonstanten.Verdoppelung * TextberechnungenBreiteGrafik.Spaltenabstand;
         
      end loop AufteilungSchleife;
      
      Textposition.y := TextberechnungenHoeheGrafik.NeueTextposition (PositionExtern   => Textposition.y,
                                                                      ZusatzwertExtern => TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
      return (Textposition.x, Textposition.y + TextberechnungenHoeheGrafik.KleinerZeilenabstand);
      
   end Steuerungsaufteilung;
   
   
   
   function Steuerung
     (AuswahlExtern : in Integer;
      WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum;
      MaximaleTextbreiteExtern : in Float)
      return Float
   is begin
            
      case
        WelcheSteuerungExtern
      is
         when TastenbelegungDatentypen.Allgemeinbelegung_Enum =>
            ArrayAnfang := MenueKonstanten.AllgemeineSteuerung + 1;
            ArrayEnde := MenueKonstanten.Einheitensteuerung - 1;
            
         when TastenbelegungDatentypen.Einheitenbelegung_Enum =>
            ArrayAnfang := MenueKonstanten.Einheitensteuerung + 1;
            ArrayEnde := MenueKonstanten.Stadtsteuerung - 1;
            
         when TastenbelegungDatentypen.Stadtbelegung_Enum =>
            ArrayAnfang := MenueKonstanten.Stadtsteuerung + 1;
            ArrayEnde := MenueKonstanten.SonstigesSteuerung - 1;
      end case;
      
      Textposition.x := TextberechnungenBreiteGrafik.KleinerSpaltenabstand;
      Textposition.y := TextberechnungenHoeheGrafik.Zeilenabstand;
      
      TextSchleife:
      for TextSchleifenwert in TextaccessVariablen.SteuerungAccess'Range loop
         
         if
           TextSchleifenwert in ArrayAnfang .. ArrayEnde
           or
             TextSchleifenwert >= MenueKonstanten.SonstigesSteuerung
         then
            Textposition.y := TextaccessverwaltungssystemErweitertGrafik.TextSkalierenFarbeZeichnen (TextExtern               => TextFestlegen (WelcheSteuerungExtern => WelcheSteuerungExtern,
                                                                                                                                                WelcheZeileExtern     => TextSchleifenwert),
                                                                                                     TextpositionExtern       => Textposition,
                                                                                                     MaximaleTextbreiteExtern => MaximaleTextbreiteExtern,
                                                                                                     TextAccessExtern         => TextaccessVariablen.SteuerungAccess (TextSchleifenwert),
                                                                                                     FarbeExtern              => TextfarbeGrafik.AuswahlfarbeFestlegen (TextnummerExtern => TextSchleifenwert,
                                                                                                                                                                        AuswahlExtern    => AuswahlExtern));
            
            InteraktionAuswahl.PositionenSteuerung (TextSchleifenwert) := Sf.Graphics.Text.getGlobalBounds (text => TextaccessVariablen.SteuerungAccess (TextSchleifenwert));
            
         elsif
           TextSchleifenwert = MenueKonstanten.Einheitensteuerung
         then
            null;
            
         else
            InteraktionAuswahl.PositionenSteuerung (TextSchleifenwert) := GrafikRecordKonstanten.Leerbereich;
         end if;
         
      end loop TextSchleife;
      
      return Textposition.y + TextberechnungenHoeheGrafik.Zeilenabstand;
      
   end Steuerung;
   
   
   
   function TextFestlegen
     (WelcheSteuerungExtern : in TastenbelegungDatentypen.Tastenbelegungskategorie_Enum;
      WelcheZeileExtern : in Positive)
      return Wide_Wide_String
   is begin
      
      if
        WelcheZeileExtern >= MenueKonstanten.SonstigesSteuerung
      then
         return To_Wide_Wide_String (Source => Menuetexte.Steuerungsmenü (WelcheZeileExtern));
           
      else
         Text := Menuetexte.Steuerungsmenü (WelcheZeileExtern) & TextKonstanten.LangerAbstand;
      end if;
                                               
      case
        WelcheSteuerungExtern
      is
         when TastenbelegungDatentypen.Allgemeinbelegung_Enum =>
            AktuelleBelegung
              := LeseTastenbelegungDatenbank.AllgemeineBelegung (BefehlExtern => TastenbelegungDatentypen.Allgemeine_Belegung_Vorhanden_Enum'Val (WelcheZeileExtern - MenueKonstanten.AllgemeineSteuerungEnumausgleich));
            
         when TastenbelegungDatentypen.Einheitenbelegung_Enum =>
            AktuelleBelegung := LeseTastenbelegungDatenbank.Einheitenbelegung (BefehlExtern => BefehleDatentypen.Einheiten_Bewegung_Enum'Val (WelcheZeileExtern - MenueKonstanten.EinheitensteuerungEnumausgleich));
            
         when TastenbelegungDatentypen.Stadtbelegung_Enum =>
            AktuelleBelegung := LeseTastenbelegungDatenbank.Stadtbelegung (BefehlExtern => BefehleDatentypen.Stadtbefehle_Vorhanden_Enum'Val (WelcheZeileExtern - MenueKonstanten.StadtsteuerungEnumausgleich));
      end case;
      
      case
        AktuelleBelegung
      is
         when Sf.Window.Keyboard.sfKeyUnknown =>
            null;

         when TastenbelegungKonstanten.TastennamenArray'Range =>
            Text := Text & TastenbelegungKonstanten.Tastennamen (AktuelleBelegung);

         when others =>
            Text := Text & Wide_Wide_Character'Val (UnbekannteTaste);
      end case;
      
      return To_Wide_Wide_String (Source => Text);
      
   end TextFestlegen;
   
   
   
   procedure Scrollen
     (BelegungslängeExtern : in Float)
   is begin
      
      ViewflächeScrollen := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeScrollen,
                                                                                                 VerhältnisExtern => (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste).width,
                                                                                                                       GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste).height));
      
      ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungScrollleiste),
                                            GrößeExtern          => ViewflächeScrollen,
                                            AnzeigebereichExtern => GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungScrollleiste));
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => ViewflächeScrollen);
      
      if
        BelegungslängeExtern <= AktuelleAuflösungshöhe
      then
         return;
         
      else
         DiagnosesystemHTSEB.Kommazahl (BelegungslängeExtern);
         Durchläufe := 2;
      end if;
      
      while BelegungslängeExtern > 100.00 * Float (Durchläufe) loop
         
         Durchläufe := Durchläufe + 1;
         
      end loop;
      
      if
        Durchläufe > InteraktionAuswahl.PositionenSteuerungsleiste'Last
      then
         MeldungssystemHTSEB.Grafik (MeldungExtern => "SteuerungsmenueGrafik.Scrollen: Zu viele Durchläufe, erlaubt: " & InteraktionAuswahl.PositionenSteuerungsleiste'Last'Wide_Wide_Image
                                     & " notwendig: " & Durchläufe'Wide_Wide_Image);
         return;
         
      else
         null;
      end if;
      
      for Schleifenwert in InteraktionAuswahl.PositionenSteuerungsleiste'First .. Durchläufe loop
         
         InteraktionAuswahl.PositionenSteuerungsleiste (Schleifenwert) := (0.00, Float (Schleifenwert - 1) * 100.00, ViewflächeScrollen.x, Float (Schleifenwert) * 100.00);
         DiagnosesystemZusatzinformationen.KommaBoxinformationen (InteraktionAuswahl.PositionenSteuerungsleiste (Schleifenwert));
         
      end loop;
      
      ViewflächeScrollen.y := BelegungslängeExtern;
      
   end Scrollen;

end SteuerungsmenueGrafik;
