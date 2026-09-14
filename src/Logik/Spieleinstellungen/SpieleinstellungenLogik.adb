with MenueDatentypen;
with GrafikDatentypen;
with SpeziesKonstanten;

with SchreibeWeltkarteneinstellungen;
with SchreibeGrafiktask;

with SpielLogik;
with KartengeneratorLogik;
with KartengroesseEinstellenLogik;
with SpieleinstellungenSpeziesLogik;
with SchwierigkeitsgradEinstellenLogik;
with MeldungssystemHTSEB;
with LadezeitenLogik;
with AuswahlaufteilungLogik;
with StandardSpielwerteSetzenLogik;
with KartengeneratorVariablenLogik;
with Spielertests;
with KartenpoleEinstellenLogik;
with KartenebenenEinstellenLogik;
with KartenartEinstellenLogik;
with KartenformEinstellenLogik;
with KartenrohstoffeEinstellenLogik;
with KartentemperaturEinstellenLogik;

package body SpieleinstellungenLogik is

   function Spieleinstellungen
     (SchnellstartExtern : in Boolean)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
            
      case
        SchnellstartExtern
      is
         when True =>
            StandardSpielwerteSetzenLogik.Standardspielwerte (EinstellungenBehaltenExtern => False);
            SpieleinstellungenSpeziesLogik.SpeziesAutomatischBelegen;
            return AutomatischeEinstellungen;
            
         when False =>
            StandardSpielwerteSetzenLogik.Standardspielwerte (EinstellungenBehaltenExtern => True);
      end case;
      
      SpielGespieltSchleife:
      loop
         SpielEinstellungenSchleife:
         loop
         
            Auswahl := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spieleinstellungen_Menü_Enum);
         
            case
              Auswahl
            is
               when RueckgabeDatentypen.Auswahl_Eins_Enum =>
                  KartenebenenEinstellenLogik.Kartenebene;
                    
               when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
                  KartengroesseEinstellenLogik.Kartengröße;
                  
               when RueckgabeDatentypen.Auswahl_Drei_Enum =>
                  KartenpoleEinstellenLogik.Kartenpole;
                  
               when RueckgabeDatentypen.Auswahl_Vier_Enum =>
                  KartenartEinstellenLogik.Kartenart;
               
               when RueckgabeDatentypen.Auswahl_Fünf_Enum =>
                  KartenformEinstellenLogik.Kartenform;

               when RueckgabeDatentypen.Auswahl_Sechs_Enum =>
                  KartentemperaturEinstellenLogik.Kartentemperatur;
               
               when RueckgabeDatentypen.Auswahl_Sieben_Enum =>
                  KartenrohstoffeEinstellenLogik.Kartenrohstoffe;

               when RueckgabeDatentypen.Auswahl_Acht_Enum =>
                  SpieleinstellungenSpeziesLogik.SpeziesWählen;

               when RueckgabeDatentypen.Auswahl_Neun_Enum =>
                  SchwierigkeitsgradEinstellenLogik.Schwierigkeitsgrad;
               
               when RueckgabeDatentypen.Fertig_Enum =>
                  if
                    SpieleinstellungenSpeziesLogik.EineSpeziesBelegt = True
                  then
                     null;
                  
                  else
                     SpieleinstellungenSpeziesLogik.SpeziesAutomatischBelegen;
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
      
      LadezeitenLogik.KartengeneratorNullsetzen;
      SchreibeGrafiktask.Darstellung (DarstellungExtern => GrafikDatentypen.Generierungszeit_Enum);
      
      -- Wird benötigt, da sonst die wichtigen Kartenwerte nicht gespeichert/geladen werden können. Sicherheitshalber immer vor Aufruf des Kartengenerators setzen.
      SchreibeWeltkarteneinstellungen.Fläche (AchsenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartengröße);
      SchreibeWeltkarteneinstellungen.Ebenen (EbenenExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenebene);
      SchreibeWeltkarteneinstellungen.Kartenform (KartenformExtern => KartengeneratorVariablenLogik.Kartenparameter.Kartenform);
      KartengeneratorLogik.Kartengenerator;
      
      SpieleinstellungenSpeziesLogik.StartwerteErmitteln;
      
      case
        Spielertests.BeliebigeSpielerart (SpeziesExtern => SpeziesKonstanten.LeerSpezies)
      is
         when True =>
            null;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "SpieleinstellungenLogik.AutomatischeEinstellungen: Speziesplatzierung unmöglich");
            return RueckgabeDatentypen.Spielmenü_Enum;
      end case;
            
      return SpielLogik.Spiel;
      
   end AutomatischeEinstellungen;

end SpieleinstellungenLogik;
