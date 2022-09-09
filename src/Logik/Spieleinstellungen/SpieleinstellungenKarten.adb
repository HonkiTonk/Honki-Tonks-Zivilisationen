pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;
with TextnummernKonstanten;
with KartenKonstanten;
with KartengeneratorRecordKonstanten;

with Karten;
with ZahleneingabeLogik;
with ZufallsgeneratorenSpieleinstellungen;
with Auswahlaufteilungen;
with Fehler;
with KartengeneratorVariablen;
with UmwandlungenVerschiedeneDatentypen;
with Kartentest;

package body SpieleinstellungenKarten is
   
   procedure KartenpoleWählen
   is begin
      
      KartenpoleSchleife:
      loop
         
         KartenpoleAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenpole_Menü_Enum);
         
         case
           KartenpoleAuswahl
         is
            when RueckgabeDatentypen.Nordpol_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum) := Polgrößen (YAchseXAchseExtern => True);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Nordpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Norden_Enum));
               
            when RueckgabeDatentypen.Südpol_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum) := Polgrößen (YAchseXAchseExtern => True);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Südpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Süden_Enum));
               
            when RueckgabeDatentypen.Westpol_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum) := Polgrößen (YAchseXAchseExtern => False);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Westpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Westen_Enum));
               
            when RueckgabeDatentypen.Ostpol_Enum =>
               KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum) := Polgrößen (YAchseXAchseExtern => False);
               KartengeneratorVariablen.Kartenparameter.Kartenpole.Ostpol := Kartentest.KartenpolePrüfen (PolgrößeExtern => KartengeneratorVariablen.Polgrößen (KartenDatentypen.Osten_Enum));
               
            when RueckgabeDatentypen.Kartenpole_Zufall_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligePole;
               
            when RueckgabeDatentypen.Standard_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenpole := KartenRecordKonstanten.KartenpoleStandard;
               KartengeneratorVariablen.Polgrößen := KartengeneratorRecordKonstanten.Eisrand;
               KartengeneratorVariablen.Eisschild := KartengeneratorRecordKonstanten.Eisschild;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenpoleWählen - Falsche Menüauswahl.");
         end case;
         
      end loop KartenpoleSchleife;
      
   end KartenpoleWählen;
   
   
   
   function Polgrößen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldNatural
   is begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            MaximaleEisdicke := Karten.Karteneinstellungen.Kartengröße.YAchse / 2;

         when False =>
            MaximaleEisdicke := Karten.Karteneinstellungen.Kartengröße.XAchse / 2;
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
         
         KartengrößeAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum);
                  
         case
           KartengrößeAuswahl
         is
            when RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (KartengrößeAuswahl);

            when RueckgabeDatentypen.Kartengröße_Nutzer_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := GrößeSelbstBestimmen;
               
            when RueckgabeDatentypen.Zufall_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (ZufallsgeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße);
               
            when RueckgabeDatentypen.Kartengröße_Zufall_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartengröße;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartengrößeWählen - Falsche Menüauswahl.");
         end case;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
            
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 20,
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.KartenfeldPositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageYAchsengrößeEingeben);
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (Karten.Karteneinstellungen.Kartengröße.YAchse, Karten.Karteneinstellungen.Kartengröße.XAchse);
            
         when True =>
            null;
      end case;
      
      YAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      
      BenutzerdefinierteGröße := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 20,
                                                                     ZahlenMaximumExtern => Positive (KartenDatentypen.KartenfeldPositiv'Last),
                                                                     WelcheFrageExtern   => TextnummernKonstanten.FrageXAchsengrößeEingeben);
      
      case
        BenutzerdefinierteGröße.ErfolgreichAbbruch
      is
         when False =>
            return (Karten.Karteneinstellungen.Kartengröße.YAchse, Karten.Karteneinstellungen.Kartengröße.XAchse);
            
         when True =>
            XAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      end case;
      
      return (YAchse, XAchse);
      
   end GrößeSelbstBestimmen;



   -- Theoretisch müsste die Unterteilung in die verschiedenen Kartenarten in KartenDatentypen entfernt werden können und nur die in RueckgabeDatentypen sind noch wichtig. äöü
   procedure KartenartWählen
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when RueckgabeDatentypen.Kartenart_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := UmwandlungenVerschiedeneDatentypen.KartenartrückgabeNachKartenart (RückgabeExtern => KartenartAuswahl);
               
               if
                 KartengeneratorVariablen.Kartenparameter.Kartenart = KartenDatentypen.Kartenart_Inseln_Enum
               then
                  KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Inselgröße;
                  KartengeneratorVariablen.Abstände := KartengeneratorRecordKonstanten.Inselabstand;
                  
               elsif
                 KartengeneratorVariablen.Kartenparameter.Kartenart = KartenDatentypen.Kartenart_Kontinente_Enum
               then
                  KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Kontinentgröße;
                  KartengeneratorVariablen.Abstände := KartengeneratorRecordKonstanten.Kontinentabstand;
                                    
               else
                  KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Pangäagröße;
                  KartengeneratorVariablen.Abstände := KartengeneratorRecordKonstanten.Pangäaabstand;
               end if;
               
            when RueckgabeDatentypen.Nutzerdefiniert_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := KartenDatentypen.Kartenart_Nutzerdefiniert_Enum;
               KartenartNutzerdefinition;
               
            when RueckgabeDatentypen.Zufall_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Kartenart_Zufall_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenart := KartenDatentypen.Kartenart_Nutzerdefiniert_Enum;
               
            when RueckgabeDatentypen.Standard_Enum =>
               KartenartStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenartWählen - Falsche Menüauswahl.");
         end case;
                      
      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   -- Könnte bei Änderung der Kartengröße zu Problemen führen. äöü
   procedure KartenartNutzerdefinition
   is begin
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.YAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MinimaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.YAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandhöhe);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MaximaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
      
      
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 1,
                                                                       ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.XAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMinimaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MinimaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => ZwischenwertKartenart,
                                                                       ZahlenMaximumExtern => Positive (Karten.Karteneinstellungen.Kartengröße.XAchse / 2),
                                                                       WelcheFrageExtern   => TextnummernKonstanten.FrageMaximaleLandbreite);
      
      case
        BenutzerdefinierteKartenart.ErfolgreichAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            KartengeneratorVariablen.Landgrößen.MaximaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
   end KartenartNutzerdefinition;



   procedure KartenartStandard
   is begin

      KartengeneratorVariablen.Kartenparameter.Kartenart := KartenKonstanten.StandardKartenart;
      KartengeneratorVariablen.Landgrößen := KartengeneratorRecordKonstanten.Inselgröße;
      KartengeneratorVariablen.Abstände := KartengeneratorRecordKonstanten.Inselabstand;

   end KartenartStandard;
   
   
   
   procedure KartenformWählen
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when RueckgabeDatentypen.Kartenform_Enum'Range =>
               KartenformZuweisen (WelcheAchseExtern => KartenformAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenform;
               
            when RueckgabeDatentypen.Standard_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenform := KartenRecordKonstanten.KartenformStandard;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen - Falsche Menüauswahl.");
         end case;

      end loop KartenformSchleife;
      
   end KartenformWählen;
   
   
   
   procedure KartenformZuweisen
     (WelcheAchseExtern : in RueckgabeDatentypen.Kartenform_Enum)
   is begin
      
      case
        WelcheAchseExtern
      is
         when RueckgabeDatentypen.Kartenübergang_E_Achse_Oben_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben = KartenDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben := KartenDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben
                 := KartenDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_E_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseOben) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_E_Achse_Unten_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten = KartenDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten := KartenDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten
                 := KartenDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_E_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.EAchseUnten) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_Y_Achse_Norden_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden
                 := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseNorden) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_Y_Achse_Süden_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden
                 := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.YAchseSüden) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_X_Achse_Westen_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten := KartenDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten
                 := KartenDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_X_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseWesten) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_X_Achse_Osten_Enum =>
            if
              KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten := KartenDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten
                 := KartenDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_X_Einstellbar_Enum'Pos (KartengeneratorVariablen.Kartenparameter.Kartenform.XAchseOsten) + 1);
            end if;
      end case;
      
   end KartenformZuweisen;



   procedure KartentemperaturWählen
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartentemperatur := UmwandlungenVerschiedeneDatentypen.KartentemperaturrückgabeNachKartentemperatur (RückgabeExtern => KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartentemperaturWählen - Falsche Menüauswahl.");
         end case;
         
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   procedure KartenressourcenWählen
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when RueckgabeDatentypen.Kartenressourcen_Enum'Range =>
               KartengeneratorVariablen.Kartenparameter.Kartenressourcen := UmwandlungenVerschiedeneDatentypen.KartenressourcenrückgabeNachKartenressource (RückgabeExtern => KartenressourcenAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               KartengeneratorVariablen.Kartenparameter.Kartenressourcen := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               
            when RueckgabeDatentypen.Fertig_Enum | RueckgabeDatentypen.Zurück_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Falsche Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKarten;
