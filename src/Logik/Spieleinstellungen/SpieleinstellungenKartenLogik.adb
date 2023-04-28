with KartenartDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;
with TextnummernKonstanten;
with KartenKonstanten;
with KartengeneratorRecordKonstanten;

with LeseWeltkarteneinstellungen;

with ZahleneingabeLogik;
with ZufallsgeneratorenSpieleinstellungenLogik;
with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with KartengeneratorVariablenLogik;
with UmwandlungenVerschiedeneDatentypen;
with KartentestsLogik;

package body SpieleinstellungenKartenLogik is
   
   procedure KartenpoleWählen
   is begin
      
      KartenpoleSchleife:
      loop
         
         KartenpoleAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenpole_Menü_Enum);
         
         case
           KartenpoleAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum) := Polgrößen (YAchseXAchseExtern => True);
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Nordpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Norden_Enum));
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum) := Polgrößen (YAchseXAchseExtern => True);
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Südpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Süden_Enum));
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum) := Polgrößen (YAchseXAchseExtern => False);
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Westpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Westen_Enum));
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum) := Polgrößen (YAchseXAchseExtern => False);
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole.Ostpol := KartentestsLogik.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablenLogik.Polgrößen (KartenartDatentypen.Osten_Enum));
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligePole;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenpole := KartenRecordKonstanten.KartenpoleStandard;
               KartengeneratorVariablenLogik.Polgrößen := KartengeneratorRecordKonstanten.Eisrand;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenKartenLogik.KartenpoleWählen: Falsche Auswahl: " & KartenpoleAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenpoleSchleife;
      
   end KartenpoleWählen;
   
   
   
   function Polgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            MaximaleEisdicke := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse / 2;

         when False =>
            MaximaleEisdicke := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse / 2;
      end case;

      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                                     ZahlenMaximumExtern => Positive (MaximaleEisdicke),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageEisschicht);
      
      if
        BenutzerdefinierteGröße.ErfolgreichAbbruch = False
        or
          BenutzerdefinierteGröße.EingegebeneZahl = 0
      then
         return 0;
         
      else
         return KartenDatentypen.KartenfeldNatural (BenutzerdefinierteGröße.EingegebeneZahl);
      end if;
      
   end Polgrößen;
   
   

   procedure KartengrößeWählen
   is begin
            
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum);
                  
         case
           KartengrößeAuswahl
         is
            when RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (KartengrößeAuswahl);

            when RueckgabeDatentypen.Auswahl_Zehn_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := GrößeSelbstBestimmen;
               
            when RueckgabeDatentypen.Auswahl_Elf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeVordefinierteKartengröße);
               
            when RueckgabeDatentypen.Auswahl_Zwölf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartengröße;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenKartenLogik.KartengrößeWählen: Falsche Auswahl: " & KartengrößeAuswahl'Wide_Wide_Image);
         end case;

         KartentestsLogik.Größenanpassung;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
            
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.MinimaleKartengröße),
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.KartenfeldPositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageYAchsengrößeEingeben);
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (LeseWeltkarteneinstellungen.YAchse, LeseWeltkarteneinstellungen.XAchse);
            
         when True =>
            null;
      end case;
      
      YAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Positive (KartenKonstanten.MinimaleKartengröße),
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.KartenfeldPositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageXAchsengrößeEingeben);
      
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (LeseWeltkarteneinstellungen.YAchse, LeseWeltkarteneinstellungen.XAchse);
            
         when True =>
            XAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      end case;
      
      return (YAchse, XAchse);
      
   end GrößeSelbstBestimmen;



   procedure KartenartWählen
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Inseln_Enum;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Kontinente_Enum;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Pangäa_Enum;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum;
               KartenartNutzerdefinition;
               
            when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeVordefinierteKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum;
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               KartenartStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               exit KartenartSchleife;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenKartenLogik.KartenartWählen: Falsche Auswahl: " & KartenartAuswahl'Wide_Wide_Image);
         end case;
                      
      end loop KartenartSchleife;
      
      case
        KartengeneratorVariablenLogik.Kartenparameter.Kartenart
      is
         when KartenartDatentypen.Kartenart_Nutzerdefiniert_Enum =>
            null;
            
         when others =>
            KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kartenartgrößen (KartengeneratorVariablenLogik.Kartenparameter.Kartenart);
      end case;
      
   end KartenartWählen;
   
   
   
   procedure KartenartNutzerdefinition
   is begin
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MinimaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.YAchse),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MaximaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
      
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MinimaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (KartengeneratorVariablenLogik.Kartenparameter.Kartengröße.XAchse),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            
         when True =>
            KartengeneratorVariablenLogik.Landgrößen.MaximaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
   end KartenartNutzerdefinition;



   procedure KartenartStandard
   is begin

      KartengeneratorVariablenLogik.Kartenparameter.Kartenart := KartenKonstanten.StandardKartenart;
      KartengeneratorVariablenLogik.Landgrößen := KartengeneratorRecordKonstanten.Kartenartgrößen (KartenartDatentypen.Kartenart_Kontinente_Enum);

   end KartenartStandard;
   
   
   
   procedure KartenformWählen
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when RueckgabeDatentypen.Kartenform_Enum'Range =>
               KartenformZuweisen (WelcheAchseExtern => KartenformAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
               ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenform;
               
            when RueckgabeDatentypen.Auswahl_Acht_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform := KartenRecordKonstanten.KartenformStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenKartenLogik.KartenformWählen: Falsche Auswahl: " & KartenformAuswahl'Wide_Wide_Image);
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;
   
   
   
   procedure KartenformZuweisen
     (WelcheAchseExtern : in RueckgabeDatentypen.Kartenform_Enum)
   is
      use type KartenartDatentypen.Kartenform_Enum;
   begin
      
      case
        WelcheAchseExtern
      is
         when RueckgabeDatentypen.Auswahl_Eins_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben = KartenartDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben := KartenartDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben
                 := KartenartDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_E_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseOben) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten = KartenartDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten := KartenartDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten
                 := KartenartDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_E_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.EAchseUnten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Drei_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden = KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden := KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden
                 := KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseNorden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Vier_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden = KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden := KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden
                 := KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.YAchseSüden) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten = KartenartDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten := KartenartDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten
                 := KartenartDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_X_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseWesten) + 1);
            end if;
            
         when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
            if
              KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten = KartenartDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten := KartenartDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten
                 := KartenartDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenartDatentypen.Kartenform_X_Einstellbar_Enum'Pos (KartengeneratorVariablenLogik.Kartenparameter.Kartenform.XAchseOsten) + 1);
            end if;
      end case;
      
   end KartenformZuweisen;



   -- Temperatur durch was anderes ersetzen, was mehr über die Kartenbeschaffenheit aussagt. äöü
   procedure KartentemperaturWählen
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur := UmwandlungenVerschiedeneDatentypen.KartentemperaturrückgabeNachKartentemperatur (RückgabeExtern => KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenKartenLogik.KartentemperaturWählen: Falsche Auswahl: " & KartentemperaturAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   procedure KartenressourcenWählen
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when RueckgabeDatentypen.Kartenressourcen_Enum'Range =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen := UmwandlungenVerschiedeneDatentypen.KartenressourcenrückgabeNachKartenressource (RückgabeExtern => KartenressourcenAuswahl);
               
            when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
               KartengeneratorVariablenLogik.Kartenparameter.Kartenressourcen := ZufallsgeneratorenSpieleinstellungenLogik.ZufälligeKartenressourcen;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpieleinstellungenKartenLogik.KartenressourcenWählen: Falsche Auswahl: " & KartenressourcenAuswahl'Wide_Wide_Image);
         end case;
         
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKartenLogik;
