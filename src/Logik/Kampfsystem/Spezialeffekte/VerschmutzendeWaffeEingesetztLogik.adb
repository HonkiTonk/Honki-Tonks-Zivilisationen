with KartenKonstanten;
with KarteneffektDatentypen;
with DiplomatieDatentypen;
with SystemDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;
with SchreibeDiplomatie;

with KartenkoordinatenberechnungssystemLogik;

package body VerschmutzendeWaffeEingesetztLogik is

   procedure VerschmutzendeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      Verschmutzungsbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                        EffektExtern  => KarteneffektDatentypen.Verschmutzt_Enum);
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Koordinaten.EAchse
      is
         when KartenKonstanten.HimmelKonstante =>
            Verschmutzungshöhe.EAchseAnfang := KartenKonstanten.OberflächeKonstante;
            Verschmutzungshöhe.EAchseEnde := KartenKonstanten.HimmelKonstante;

         when others =>
            Verschmutzungshöhe.EAchseAnfang := Koordinaten.EAchse;
            Verschmutzungshöhe.EAchseEnde := Koordinaten.EAchse;
      end case;
      
      EAchseSchleife:
      for EAchseSchleifenwert in Verschmutzungshöhe.EAchseAnfang .. Verschmutzungshöhe.EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in Verschmutzungsbereich.YAchseAnfang .. Verschmutzungsbereich.YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in Verschmutzungsbereich.XAchseAnfang .. Verschmutzungsbereich.XAchseEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EAchseSchleifenwert, Koordinaten.YAchse, Koordinaten.XAchse),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         TaskExtern => SystemDatentypen.Logik_Task_Enum);
               
               case
                 Kartenwert.EAchse
               is
                  when KartenKonstanten.LeerEAchse =>
                     null;
                     
                  when others =>
                     SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => Kartenwert,
                                                   FeldeffektExtern  => KarteneffektDatentypen.Verschmutzt_Enum);
               end case;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         if
           SpeziesSchleifenwert = EinheitSpeziesNummerExtern.Spezies
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         else
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => EinheitSpeziesNummerExtern.Spezies,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KarteneffektDatentypen.Verschmutzt_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end VerschmutzendeWaffeEingesetzt;

end VerschmutzendeWaffeEingesetztLogik;
