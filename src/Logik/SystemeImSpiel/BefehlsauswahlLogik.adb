with TasteneingabeLogik;
with CursorbewegungLogik;
with ForschungsauswahlLogik;
with DiplomatieLogik;
with DebugmenueLogik;
with BefehlspruefungenLogik;
with StadtSuchenLogik;
with MausauswahlLogik;
with NaechsteEinheitLogik;
with NaechsteStadtLogik;

package body BefehlsauswahlLogik is

   function Befehlsauswahl
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      Befehl := TasteneingabeLogik.AllgemeineTaste;
      
      case
        Befehl
      is
         when TastenbelegungDatentypen.Auswählen_Enum =>
            return Tasteneingabe (SpeziesExtern => SpeziesExtern,
                                  BefehlExtern  => MausauswahlLogik.Weltkartenbefehle);
            
         when others =>
            return Tasteneingabe (SpeziesExtern => SpeziesExtern,
                                  BefehlExtern  => Befehl);
      end case;
      
   end Befehlsauswahl;
   
   
   
   function Tasteneingabe
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      BefehlExtern : in TastenbelegungDatentypen.Allgemeine_Belegung_Enum)
      return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin

      case
        BefehlExtern
      is
         when TastenbelegungDatentypen.Tastenbelegung_Bewegung_Enum'Range =>
            CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => BefehlExtern,
                                                         SpeziesExtern    => SpeziesExtern);
            
         when TastenbelegungDatentypen.Auswählen_Enum =>
            BefehlspruefungenLogik.AuswahlEinheitStadt (SpeziesExtern => SpeziesExtern);
            
         when TastenbelegungDatentypen.Abwählen_Enum =>
            return RueckgabeDatentypen.Spielmenü_Enum;
           
         when TastenbelegungDatentypen.Forschung_Enum =>
            ForschungsauswahlLogik.Forschung (SpeziesExtern => SpeziesExtern);
            
         when TastenbelegungDatentypen.Nächste_Stadt_Enum =>
            NaechsteStadtLogik.NächsteStadt (SpeziesExtern => SpeziesExtern);
            
         when TastenbelegungDatentypen.Einheit_Mit_Bewegungspunkte_Enum =>
            NaechsteEinheitLogik.NächsteEinheit (SpeziesExtern           => SpeziesExtern,
                                                  BewegungspunkteExtern => NaechsteEinheitLogik.Hat_Bewegungspunkte_Enum);
            
         when TastenbelegungDatentypen.Nächste_Einheit_Enum =>
            NaechsteEinheitLogik.NächsteEinheit (SpeziesExtern           => SpeziesExtern,
                                                  BewegungspunkteExtern => NaechsteEinheitLogik.Egal_Bewegungspunkte_Enum);
            
         when TastenbelegungDatentypen.Einheiten_Ohne_Bewegungspunkte_Enum =>
            NaechsteEinheitLogik.NächsteEinheit (SpeziesExtern           => SpeziesExtern,
                                                  BewegungspunkteExtern => NaechsteEinheitLogik.Keine_Bewegungspunkte_Enum);

         when TastenbelegungDatentypen.Diplomatie_Enum =>
            DiplomatieLogik.DiplomatieMöglich (SpeziesExtern => SpeziesExtern);

         when TastenbelegungDatentypen.Gehe_Zu_Enum =>
            CursorbewegungLogik.GeheZu;
            
         when TastenbelegungDatentypen.Stadt_Suchen_Enum =>
            StadtSuchenLogik.StadtNachNamenSuchen;
            
         when TastenbelegungDatentypen.Nächste_Stadt_Mit_Meldung_Enum =>
            NaechsteStadtLogik.NächsteStadtMeldung (SpeziesExtern => SpeziesExtern);
            
         when TastenbelegungDatentypen.Nächste_Einheit_Mit_Meldung_Enum =>
            NaechsteEinheitLogik.NächsteEinheitMeldung (SpeziesExtern => SpeziesExtern);
            
         when TastenbelegungDatentypen.Runde_Beenden_Enum =>
            return RueckgabeDatentypen.Runde_Beenden_Enum;
            
         when TastenbelegungDatentypen.Debugmenü_Enum =>
            DebugmenueLogik.Debugmenü (SpeziesExtern => SpeziesExtern);
            
         when TastenbelegungDatentypen.Leer_Allgemeine_Belegung_Enum =>
            null;
      end case;
      
      return RueckgabeDatentypen.Start_Weiter_Enum;
      
   end Tasteneingabe;

end BefehlsauswahlLogik;
