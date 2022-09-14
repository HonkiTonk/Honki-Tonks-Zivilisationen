pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen;
with MenueDatentypen;
with GrafikDatentypen;

with SpielLogik;
with Kartengenerator;
with SpieleinstellungenKarten;
with SpieleinstellungenRasseSpieler;
with SpieleinstellungenSonstiges;
with Warnung;
with LadezeitenLogik;
with AuswahlaufteilungLogik;
with NachGrafiktask;
with StandardSpielwerteSetzenLogik;
with Karten;
with KartengeneratorVariablen;
with Spielertests;

package body Spieleinstellungen is

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      StandardSpielwerteSetzenLogik.StandardSpielwerteSetzenLogik (EinstellungenBehaltenExtern => True);
      
      case
        SchnellstartExtern
      is
         when True =>
            SpieleinstellungenRasseSpieler.RasseBelegenSchnellstart;
            return AutomatischeEinstellungen;
            
         when False =>
            null;
      end case;
      
      SpielGespieltSchleife:
      loop
         SpielEinstellungenSchleife:
         loop
         
            Auswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Einstellungen_Menü_Enum);
         
            case
              Auswahl
            is
               when RueckgabeDatentypen.Auswahl_Eins_Enum =>
                  SpieleinstellungenKarten.KartenpoleWählen;
                    
               when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
                  SpieleinstellungenKarten.KartengrößeWählen;

               when RueckgabeDatentypen.Auswahl_Drei_Enum =>
                  SpieleinstellungenKarten.KartenartWählen;
               
               when RueckgabeDatentypen.Auswahl_Vier_Enum =>
                  SpieleinstellungenKarten.KartenformWählen;

               when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
                  SpieleinstellungenKarten.KartentemperaturWählen;
               
               when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
                  SpieleinstellungenKarten.KartenressourcenWählen;

               when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
                  SpieleinstellungenRasseSpieler.RassenWählen;

               when RueckgabeDatentypen.Auswahl_Acht_Enum =>
                  SpieleinstellungenSonstiges.SchwierigkeitsgradFestlegen;
               
               when RueckgabeDatentypen.Fertig_Enum =>
                  if
                    SpieleinstellungenRasseSpieler.EineRasseBelegt = True
                  then
                     null;
                  
                  else
                     SpieleinstellungenRasseSpieler.RasseAutomatischBelegen;
                  end if;
                  
                  exit SpielEinstellungenSchleife;

               when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
                  return Auswahl;

               when others =>
                  null;
            end case;

         end loop SpielEinstellungenSchleife;
         
         Rückgabewert := AutomatischeEinstellungen;
         
         case
           Rückgabewert
         is
            when RueckgabeDatentypen.Spielmenü_Enum =>
               null;
               
            when others =>
               return Rückgabewert;
         end case;
         
      end loop SpielGespieltSchleife;
              
   end Spieleinstellungen;
   
   
   
   function AutomatischeEinstellungen
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      -- Nullsetzen der Ladezeiten und das Wechseln der Grafikanzeige kombinieren? äöü
      LadezeitenLogik.SpielweltNullsetzen;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Generierungszeit_Enum;

      -- Wird benötigt, da sonst die wichtigen Kartenwerte nicht gespeichert/geladen werden können. Sicherheitshalber immer vor Aufruf des Kartengenerators setzen.
      Karten.Karteneinstellungen.Kartengröße := KartengeneratorVariablen.Kartenparameter.Kartengröße;
      Karten.Karteneinstellungen.Kartenform := KartengeneratorVariablen.Kartenparameter.Kartenform;
      Kartengenerator.Kartengenerator;
      
      SpieleinstellungenRasseSpieler.StartwerteErmitteln;
      
      case
        Spielertests.BeliebigeSpielerart (RasseExtern => RassenDatentypen.Keine_Rasse_Enum)
      is
         when True =>
            null;
            
         when False =>
            Warnung.LogikWarnung (WarnmeldungExtern => "SpielEinstellungen.AutomatischeEinstellungen: Keine Rassenplatzierung möglich.");
            return RueckgabeDatentypen.Spielmenü_Enum;
      end case;
            
      return SpielLogik.Spiel;
      
   end AutomatischeEinstellungen;

end Spieleinstellungen;
