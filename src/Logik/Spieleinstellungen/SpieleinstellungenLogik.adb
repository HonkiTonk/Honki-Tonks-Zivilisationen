with RassenDatentypen;
with MenueDatentypen;
with GrafikDatentypen;
with Weltkarte;

with SpielLogik;
with KartengeneratorLogik;
with SpieleinstellungenKartenLogik;
with SpieleinstellungenRasseLogik;
with SpieleinstellungenSonstigesLogik;
with Fehlermeldungssystem;
with LadezeitenLogik;
with AuswahlaufteilungLogik;
with NachGrafiktask;
with StandardSpielwerteSetzenLogik;
with KartengeneratorVariablenLogik;
with Spielertests;

package body SpieleinstellungenLogik is

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      StandardSpielwerteSetzenLogik.StandardSpielwerteSetzenLogik (EinstellungenBehaltenExtern => True);
      
      case
        SchnellstartExtern
      is
         when True =>
            SpieleinstellungenRasseLogik.RasseBelegenSchnellstart;
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
                  SpieleinstellungenKartenLogik.KartenpoleWählen;
                    
               when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
                  SpieleinstellungenKartenLogik.KartengrößeWählen;

               when RueckgabeDatentypen.Auswahl_Drei_Enum =>
                  SpieleinstellungenKartenLogik.KartenartWählen;
               
               when RueckgabeDatentypen.Auswahl_Vier_Enum =>
                  SpieleinstellungenKartenLogik.KartenformWählen;

               when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
                  SpieleinstellungenKartenLogik.KartentemperaturWählen;
               
               when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
                  SpieleinstellungenKartenLogik.KartenressourcenWählen;

               when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
                  SpieleinstellungenRasseLogik.RassenWählen;

               when RueckgabeDatentypen.Auswahl_Acht_Enum =>
                  SpieleinstellungenSonstigesLogik.SchwierigkeitsgradFestlegen;
               
               when RueckgabeDatentypen.Fertig_Enum =>
                  if
                    SpieleinstellungenRasseLogik.EineRasseBelegt = True
                  then
                     null;
                  
                  else
                     SpieleinstellungenRasseLogik.RasseAutomatischBelegen;
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
      
      LadezeitenLogik.SpielweltNullsetzen;
      NachGrafiktask.AktuelleDarstellung := GrafikDatentypen.Grafik_Generierungszeit_Enum;
      
      -- Wird benötigt, da sonst die wichtigen Kartenwerte nicht gespeichert/geladen werden können. Sicherheitshalber immer vor Aufruf des Kartengenerators setzen.
      Weltkarte.Karteneinstellungen.Kartengröße := KartengeneratorVariablenLogik.Kartenparameter.Kartengröße;
      Weltkarte.Karteneinstellungen.Kartenform := KartengeneratorVariablenLogik.Kartenparameter.Kartenform;
      KartengeneratorLogik.Kartengenerator;
      
      SpieleinstellungenRasseLogik.StartwerteErmitteln;
      
      case
        Spielertests.BeliebigeSpielerart (RasseExtern => RassenDatentypen.Keine_Rasse_Enum)
      is
         when True =>
            null;
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "SpielEinstellungen.AutomatischeEinstellungen: Rassenplatzierung unmöglich.");
            return RueckgabeDatentypen.Spielmenü_Enum;
      end case;
            
      return SpielLogik.Spiel;
      
   end AutomatischeEinstellungen;

end SpieleinstellungenLogik;
