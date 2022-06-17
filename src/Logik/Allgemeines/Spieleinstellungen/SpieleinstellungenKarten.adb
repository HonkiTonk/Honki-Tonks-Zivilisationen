pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

with KartenDatentypen; use KartenDatentypen;
with MenueDatentypen;
with KartenRecordKonstanten;
with TextKonstanten;
with KartenKonstanten;

with Karten;
with Eingabe;
with ZufallsgeneratorenSpieleinstellungen;
with AuswahlMenues;
with Fehler;

package body SpieleinstellungenKarten is
   
   procedure KartenpoleWählen
   is begin
      
      KartenpoleSchleife:
      loop
         
         KartenpoleAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenpole_Menü_Enum);
         
         case
           KartenpoleAuswahl
         is
            when RueckgabeDatentypen.Nordpol_Enum =>
               if
                 Karten.Kartenparameter.Kartenpole.Nordpol = KartenDatentypen.Kartenpol_Vorhanden_Enum
               then
                  Karten.Kartenparameter.Kartenpole.Nordpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                  Karten.Polgrößen (KartenDatentypen.Norden_Enum) := 0;
                  
               else
                  EingegebeneEisdicke := Polgrößen (YAchseXAchseExtern => True);
                  
                  case
                    EingegebeneEisdicke
                  is
                     when 0 =>
                        Karten.Kartenparameter.Kartenpole.Nordpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                        
                     when others =>
                        Karten.Kartenparameter.Kartenpole.Nordpol := KartenDatentypen.Kartenpol_Vorhanden_Enum;
                  end case;
                  
                  Karten.Polgrößen (KartenDatentypen.Norden_Enum) := EingegebeneEisdicke;
               end if;
               
            when RueckgabeDatentypen.Südpol_Enum =>
               if
                 Karten.Kartenparameter.Kartenpole.Südpol = KartenDatentypen.Kartenpol_Vorhanden_Enum
               then
                  Karten.Kartenparameter.Kartenpole.Südpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                  Karten.Polgrößen (KartenDatentypen.Süden_Enum) := 0;
                  
               else
                  EingegebeneEisdicke := Polgrößen (YAchseXAchseExtern => True);
                  
                  case
                    EingegebeneEisdicke
                  is
                     when 0 =>
                        Karten.Kartenparameter.Kartenpole.Südpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                        
                     when others =>
                        Karten.Kartenparameter.Kartenpole.Südpol := KartenDatentypen.Kartenpol_Vorhanden_Enum;
                  end case;
                  
                  Karten.Polgrößen (KartenDatentypen.Süden_Enum) := EingegebeneEisdicke;
               end if;
               
            when RueckgabeDatentypen.Westpol_Enum =>
               if
                 Karten.Kartenparameter.Kartenpole.Westpol = KartenDatentypen.Kartenpol_Vorhanden_Enum
               then
                  Karten.Kartenparameter.Kartenpole.Westpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                  Karten.Polgrößen (KartenDatentypen.Westen_Enum) := 0;
                  
               else
                  EingegebeneEisdicke := Polgrößen (YAchseXAchseExtern => False);
                  
                  case
                    EingegebeneEisdicke
                  is
                     when 0 =>
                        Karten.Kartenparameter.Kartenpole.Westpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                        
                     when others =>
                        Karten.Kartenparameter.Kartenpole.Westpol := KartenDatentypen.Kartenpol_Vorhanden_Enum;
                  end case;
                  
                  Karten.Polgrößen (KartenDatentypen.Westen_Enum) := EingegebeneEisdicke;
               end if;
               
            when RueckgabeDatentypen.Ostpol_Enum =>
               if
                 Karten.Kartenparameter.Kartenpole.Ostpol = KartenDatentypen.Kartenpol_Vorhanden_Enum
               then
                  Karten.Kartenparameter.Kartenpole.Ostpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                  Karten.Polgrößen (KartenDatentypen.Osten_Enum) := 0;
                  
               else
                  EingegebeneEisdicke := Polgrößen (YAchseXAchseExtern => False);
                  
                  case
                    EingegebeneEisdicke
                  is
                     when 0 =>
                        Karten.Kartenparameter.Kartenpole.Ostpol := KartenDatentypen.Kartenpol_Nicht_Vorhanden_Enum;
                        
                     when others =>
                        Karten.Kartenparameter.Kartenpole.Ostpol := KartenDatentypen.Kartenpol_Vorhanden_Enum;
                  end case;
                  
                  Karten.Polgrößen (KartenDatentypen.Osten_Enum) := EingegebeneEisdicke;
               end if;
               
            when RueckgabeDatentypen.Kartenpole_Zufall_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligePole;
               
            when RueckgabeDatentypen.Standard_Enum =>
               Karten.Kartenparameter.Kartenpole := KartenRecordKonstanten.KartenpoleStandard;
               Karten.Polgrößen := KartenRecordKonstanten.Eisrand;
               Karten.Eisschild := KartenRecordKonstanten.Eisschild;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Put_Line (KartenpoleAuswahl'Wide_Wide_Image);
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenpoleWählen - Ungültige Menüauswahl.");
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
            MaximaleEisdicke := Karten.Kartenparameter.Kartengröße.YAchse / 2;

         when False =>
            MaximaleEisdicke := Karten.Kartenparameter.Kartengröße.XAchse / 2;
      end case;

      BenutzerdefinierteGröße := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageEisschicht,
                                                      ZahlenMinimumExtern => 0,
                                                      ZahlenMaximumExtern => Positive (MaximaleEisdicke));
      if
        BenutzerdefinierteGröße.EingabeAbbruch = False
        or
          BenutzerdefinierteGröße.EingegebeneZahl = 0
      then
         return 0;
         
      else
         return KartenDatentypen.KartenfeldNatural (BenutzerdefinierteGröße.EingegebeneZahl);
      end if;
      
   end Polgrößen;
   
   

   ----------------------- Bei Zufall auch zurück?
   procedure KartengrößeWählen
   is begin
      
      KartengrößeSchleife:
      loop
         
         KartengrößeAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartengröße_Menü_Enum);
         
         case
           KartengrößeAuswahl
         is
            when RueckgabeDatentypen.Kartengrößen_Standard_Enum'Range =>
               Karten.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (KartengrößeAuswahl);

            when RueckgabeDatentypen.Kartengröße_Nutzer_Enum =>
               Karten.Kartenparameter.Kartengröße := GrößeSelbstBestimmen;
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := KartenKonstanten.StandardKartengrößen (ZufallsgeneratorenSpieleinstellungen.ZufälligeVordefinierteKartengröße);
               
            when RueckgabeDatentypen.Kartengröße_Zufall_Enum =>
               Karten.Kartenparameter.Kartengröße := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartengröße;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartengrößeWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop KartengrößeSchleife;
      
   end KartengrößeWählen;
   
   
   
   function GrößeSelbstBestimmen
     return KartenRecords.YXAchsenKartenfeldPositivRecord
   is begin
            
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (ZeileExtern         => 15,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      case
        BenutzerdefinierteGröße.EingabeAbbruch
      is
         when False =>
            return (Karten.Kartenparameter.Kartengröße.YAchse, Karten.Kartenparameter.Kartengröße.XAchse);
            
         when True =>
            null;
      end case;
      
      YAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      
      BenutzerdefinierteGröße := Eingabe.GanzeZahl (ZeileExtern         => 21,
                                                      ZahlenMinimumExtern => 20,
                                                      ZahlenMaximumExtern => 1_000);
      
      case
        BenutzerdefinierteGröße.EingabeAbbruch
      is
         when False =>
            return (Karten.Kartenparameter.Kartengröße.YAchse, Karten.Kartenparameter.Kartengröße.XAchse);
            
         when True =>
            XAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteGröße.EingegebeneZahl);
      end case;
      
      return (YAchse, XAchse);
      
   end GrößeSelbstBestimmen;



   -- Inseln, Kontinente, Pangäa, Nur Land
   ------------------------------------ Theoretisch müsste die Unterteilung in die verschiedenen Kartenarten in KartenDatentypen entfernt werden können und nur die in RueckgabeDatentypen sind noch wichtig.
   procedure KartenartWählen
   is begin
            
      KartenartSchleife:
      loop

         KartenartAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenart_Menü_Enum);
         
         case
           KartenartAuswahl
         is
            when RueckgabeDatentypen.Kartenart_Enum'Range =>
               Karten.Kartenparameter.Kartenart := KartenartRückgabeZuKarten (KartenartAuswahl);
               
            when RueckgabeDatentypen.Nutzerdefiniert_Enum =>
               Karten.Kartenparameter.Kartenart := KartenDatentypen.Kartenart_Nutzerdefiniert_Enum;
               KartenartNutzerdefinition;
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenart := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenart;
               
            when RueckgabeDatentypen.Kartenart_Zufall_Enum =>
               Karten.Kartenparameter.Kartenart := KartenDatentypen.Kartenart_Nutzerdefiniert_Enum;
               
            when RueckgabeDatentypen.Standard_Enum =>
               KartenartStandard;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenartWählen - Ungültige Menüauswahl.");
         end case;

      end loop KartenartSchleife;
      
   end KartenartWählen;
   
   
   
   ----------------------------------- Könnte bei Änderung der Kartengröße zu Problemen führen.
   procedure KartenartNutzerdefinition
   is begin
      
      BenutzerdefinierteKartenart := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageMinimaleLandhöhe,
                                                        ZahlenMinimumExtern => 1,
                                                        ZahlenMaximumExtern => Positive (Karten.Kartenparameter.Kartengröße.YAchse / 2));
      
      case
        BenutzerdefinierteKartenart.EingabeAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Karten.Landgrößen.MinimaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageMaximaleLandhöhe,
                                                        ZahlenMinimumExtern => ZwischenwertKartenart,
                                                        ZahlenMaximumExtern => Positive (Karten.Kartenparameter.Kartengröße.YAchse / 2));
      
      case
        BenutzerdefinierteKartenart.EingabeAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Karten.Landgrößen.MaximaleYAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
      
      
      BenutzerdefinierteKartenart := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageMinimaleLandbreite,
                                                        ZahlenMinimumExtern => 1,
                                                        ZahlenMaximumExtern => Positive (Karten.Kartenparameter.Kartengröße.XAchse / 2));
      
      case
        BenutzerdefinierteKartenart.EingabeAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Karten.Landgrößen.MinimaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
            ZwischenwertKartenart := BenutzerdefinierteKartenart.EingegebeneZahl;
      end case;
            
      BenutzerdefinierteKartenart := Eingabe.GanzeZahl (ZeileExtern         => TextKonstanten.FrageMaximaleLandbreite ,
                                                        ZahlenMinimumExtern => ZwischenwertKartenart,
                                                        ZahlenMaximumExtern => Positive (Karten.Kartenparameter.Kartengröße.XAchse / 2));
      
      case
        BenutzerdefinierteKartenart.EingabeAbbruch
      is
         when False =>
            KartenartStandard;
            return;
            
         when True =>
            Karten.Landgrößen.MaximaleXAchse := KartenDatentypen.KartenfeldPositiv (BenutzerdefinierteKartenart.EingegebeneZahl);
      end case;
      
   end KartenartNutzerdefinition;



   procedure KartenartStandard
   is begin

      Karten.Kartenparameter.Kartenart := KartenRecordKonstanten.KartenparameterStandard.Kartenart;
      Karten.Landgrößen := KartenRecordKonstanten.Inselgröße;
      Karten.Abstände := KartenRecordKonstanten.Inselabstand;

   end KartenartStandard;
   
   
   
   procedure KartenformWählen
   is begin
      
      KartenformSchleife:
      loop

         KartenformAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenform_Menü_Enum);
         
         case
           KartenformAuswahl
         is
            when RueckgabeDatentypen.Kartenform_Enum'Range =>
               KartenformZuweisen (WelcheAchseExtern => KartenformAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenform;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenformWählen - Ungültige Menüauswahl.");
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
              Karten.Kartenparameter.Kartenform.EAchseOben = KartenDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               Karten.Kartenparameter.Kartenform.EAchseOben := KartenDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               Karten.Kartenparameter.Kartenform.EAchseOben
                 := KartenDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_E_Einstellbar_Enum'Pos (Karten.Kartenparameter.Kartenform.EAchseOben) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_E_Achse_Unten_Enum =>
            if
              Karten.Kartenparameter.Kartenform.EAchseUnten = KartenDatentypen.Kartenform_E_Einstellbar_Enum'Last
            then
               Karten.Kartenparameter.Kartenform.EAchseUnten := KartenDatentypen.Kartenform_E_Einstellbar_Enum'First;
               
            else
               Karten.Kartenparameter.Kartenform.EAchseUnten
                 := KartenDatentypen.Kartenform_E_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_E_Einstellbar_Enum'Pos (Karten.Kartenparameter.Kartenform.EAchseUnten) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_Y_Achse_Norden_Enum =>
            if
              Karten.Kartenparameter.Kartenform.YAchseNorden = KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               Karten.Kartenparameter.Kartenform.YAchseNorden := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               Karten.Kartenparameter.Kartenform.YAchseNorden
                 := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (Karten.Kartenparameter.Kartenform.YAchseNorden) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_Y_Achse_Süden_Enum =>
            if
              Karten.Kartenparameter.Kartenform.YAchseSüden = KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Last
            then
               Karten.Kartenparameter.Kartenform.YAchseSüden := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'First;
               
            else
               Karten.Kartenparameter.Kartenform.YAchseSüden
                 := KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_Y_Einstellbar_Enum'Pos (Karten.Kartenparameter.Kartenform.YAchseSüden) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_X_Achse_Westen_Enum =>
            if
              Karten.Kartenparameter.Kartenform.XAchseWesten = KartenDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               Karten.Kartenparameter.Kartenform.XAchseWesten := KartenDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               Karten.Kartenparameter.Kartenform.XAchseWesten
                 := KartenDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_X_Einstellbar_Enum'Pos (Karten.Kartenparameter.Kartenform.XAchseWesten) + 1);
            end if;
            
         when RueckgabeDatentypen.Kartenübergang_X_Achse_Osten_Enum =>
            if
              Karten.Kartenparameter.Kartenform.XAchseOsten = KartenDatentypen.Kartenform_X_Einstellbar_Enum'Last
            then
               Karten.Kartenparameter.Kartenform.XAchseOsten := KartenDatentypen.Kartenform_X_Einstellbar_Enum'First;
               
            else
               Karten.Kartenparameter.Kartenform.XAchseOsten
                 := KartenDatentypen.Kartenform_X_Einstellbar_Enum'Val (KartenDatentypen.Kartenform_X_Einstellbar_Enum'Pos (Karten.Kartenparameter.Kartenform.XAchseOsten) + 1);
            end if;
      end case;
      
   end KartenformZuweisen;



   -- Kalt, Gemäßigt, Heiß, Eiszeit, Wüste
   procedure KartentemperaturWählen
   is begin
            
      KartentemperaturSchleife:
      loop

         KartentemperaturAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartentemperatur_Menü_Enum);
                  
         case
           KartentemperaturAuswahl
         is
            when RueckgabeDatentypen.Kartentemperatur_Enum'Range =>
               Karten.Kartenparameter.Kartentemperatur := KartentemperaturRückgabeZuKarten (KartentemperaturAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartentemperatur := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartentemperatur;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartentemperaturWählen - Ungültige Menüauswahl.");
         end case;
         
      end loop KartentemperaturSchleife;
      
   end KartentemperaturWählen;
   
   
   
   -- Arm, Wenig, Mittel, Viel, Überfluss
   procedure KartenressourcenWählen
   is begin
      
      KartenressourcenSchleife:
      loop

         KartenressourcenAuswahl := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Kartenressourcen_Menü_Enum);
         
         case
           KartenressourcenAuswahl
         is
            when RueckgabeDatentypen.Kartenressourcen_Enum'Range =>
               Karten.Kartenparameter.Kartenressourcen := KartenressourcenRückgabeZuKarten (KartenressourcenAuswahl);
               
            when RueckgabeDatentypen.Zufall_Enum =>
               Karten.Kartenparameter.Kartenressourcen := ZufallsgeneratorenSpieleinstellungen.ZufälligeKartenressourcen;
               
            when RueckgabeDatentypen.Fertig_Enum =>
               return;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "SpielEinstellungenKarten.KartenressourcenWählen - Ungültige Menüauswahl.");
         end case;
                  
      end loop KartenressourcenSchleife;
      
   end KartenressourcenWählen;

end SpieleinstellungenKarten;
