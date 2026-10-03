with MeldungssystemHTSEB;

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
               when Kartenebene =>
                  KartenebenenEinstellenLogik.Kartenebene;
                    
               when Kartengröße =>
                  KartengroesseEinstellenLogik.Kartengröße;
                  
               when Kartenpole =>
                  KartenpoleEinstellenLogik.Kartenpole;
                  
               when Kartenart =>
                  KartenartEinstellenLogik.Kartenart;
               
               when Kartenform =>
                  KartenformEinstellenLogik.Kartenform;

               when Kartentemperatur =>
                  KartentemperaturEinstellenLogik.Kartentemperatur;
               
               when Kartenrohstoffe =>
                  KartenrohstoffeEinstellenLogik.Kartenrohstoffe;

               when Spezies =>
                  SpieleinstellungenSpeziesLogik.SpeziesWählen;

               when Schwierigkeitsgrad =>
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
            when Spielmenü =>
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
      SchreibeWeltkarteneinstellungen.Fläche (AchsenExtern => KartengeneratorVariablenLogik.KartengrößeLesen);
      SchreibeWeltkarteneinstellungen.Ebenen (EbenenExtern => KartengeneratorVariablenLogik.KartenebenenLesen);
      SchreibeWeltkarteneinstellungen.Kartenform (KartenformExtern => KartengeneratorVariablenLogik.KartenformLesen);
      
      KartengeneratorLogik.Kartengenerator;
      
      SpieleinstellungenSpeziesLogik.StartwerteErmitteln;
      
      case
        Spielertests.BeliebigeSpielerart (SpeziesExtern => SpeziesKonstanten.LeerSpezies)
      is
         when True =>
            null;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "SpieleinstellungenLogik.AutomatischeEinstellungen: Speziesplatzierung unmöglich");
            return Spielmenü;
      end case;
      
      KarteErstellt := True;
            
      Zwischenspeicher := SpielLogik.Spiel;
      
      KarteErstellt := False;
      
      return Zwischenspeicher;
      
   end AutomatischeEinstellungen;
   
   
   
   function KarteVorhanden
     return Boolean
   is begin
      
      return KarteErstellt;
      
   end KarteVorhanden;

end SpieleinstellungenLogik;
