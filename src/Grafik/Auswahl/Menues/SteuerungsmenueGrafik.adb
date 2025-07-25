with Sf.Graphics.Text;

with TextKonstantenHTSEB;

with Views;
with GrafikDatentypen;
with TextaccessVariablen;
with TastenbelegungKonstanten;
with Menuetexte;
with BefehleDatentypen;
with ViewKonstanten;
with TextDatentypen;
with GrafikKonstanten;

with LeseTastenbelegungDatenbank;
with SchreibeLogiktask;

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
with ScrollleisteGrafik;

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
      AktuelleAuflösungshöhe := FensterGrafik.AktuelleAuflösung.y * Anzeigemodifikator;
      
      if
        ViewflächeBelegung.y <= AktuelleAuflösungshöhe
      then
         Vollauswahl := True;
         Auswahlverhältnis := (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungVollauswahl).width, GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungVollauswahl).height);
         Anzeigebereich := GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungVollauswahl);
         SchreibeLogiktask.Scrollleiste (ScrollleisteExtern => False);
         
      else
         Vollauswahl := False;
         Auswahlverhältnis := (GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungTeilauswahl).width, GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungTeilauswahl).height);
         Anzeigebereich := GrafikRecordKonstanten.Steuerungbereich (ViewKonstanten.SteuerungTeilauswahl);
         SchreibeLogiktask.Scrollleiste (ScrollleisteExtern => True);
      end if;
      
      ViewflächeBelegung := ViewsEinstellenGrafik.ViewflächeWaagerechteFestSenkrechteVariabel (ViewflächeExtern => ViewflächeBelegung,
                                                                                                 VerhältnisExtern => Auswahlverhältnis);
      
      if
        Vollauswahl = False
      then
         Anzeigebereich.height := ViewflächeBelegung.y * Auswahlverhältnis.y / AktuelleAuflösungshöhe;
         
         Scrollweite := (ViewflächeBelegung.y - AktuelleAuflösungshöhe) / Float (InteraktionAuswahl.PositionenSteuerungsleiste'Last - 1);
         Bewegung.y := Float (AuswahlExtern.Zweitauswahl - 1) * Scrollweite;
         
         ViewsEinstellenGrafik.ViewEinstellenBewegen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungTeilauswahl),
                                                      GrößeExtern          => ViewflächeBelegung,
                                                      BewegungExtern       => Bewegung,
                                                      AnzeigebereichExtern => Anzeigebereich);
         
      else
         ViewsEinstellenGrafik.ViewEinstellen (ViewExtern           => Views.SteuerungviewAccesse (ViewKonstanten.SteuerungVollauswahl),
                                               GrößeExtern          => ViewflächeBelegung,
                                               AnzeigebereichExtern => Anzeigebereich);
      end if;
      
      HintergrundGrafik.Aufteilung (HintergrundExtern => GrafikDatentypen.Menü_Enum,
                                    AbmessungenExtern => ViewflächeBelegung);
      
      ViewflächeBelegung.y := Steuerung (AuswahlExtern            => AuswahlExtern.Erstauswahl,
                                          WelcheSteuerungExtern    => SteuerungsauswahlLogik.WelcheSteuerung,
                                          MaximaleTextbreiteExtern => ViewflächeBelegung.x - TextberechnungenBreiteGrafik.Spaltenabstand);
      
      
      
      -- Zum Scrollen.
      case
        Vollauswahl
      is
         when True =>
            null;
         
         when False =>
            ScrollleisteGrafik.Scrollen (AbschnittExtern => AuswahlExtern.Zweitauswahl - 1);
      end case;
      
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
      
      Textposition.x := TextberechnungenBreiteGrafik.Spaltenabstand; -- .KleinerSpaltenabstand;
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
         Text := Menuetexte.Steuerungsmenü (WelcheZeileExtern) & TextKonstantenHTSEB.LangerAbstand;
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

end SteuerungsmenueGrafik;
