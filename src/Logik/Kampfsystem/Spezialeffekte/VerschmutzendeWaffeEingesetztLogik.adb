with KartenKonstanten;
with KartenextraDatentypen;
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
                                                                        EffektExtern  => KartenextraDatentypen.Verschmutzt_Enum);
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        Koordinaten.Ebene
      is
         when KartenKonstanten.HimmelKonstante =>
            Verschmutzungshöhe.EbeneAnfang := KartenKonstanten.OberflächeKonstante;
            Verschmutzungshöhe.EbeneEnde := KartenKonstanten.HimmelKonstante;

         when others =>
            Verschmutzungshöhe.EbeneAnfang := Koordinaten.Ebene;
            Verschmutzungshöhe.EbeneEnde := Koordinaten.Ebene;
      end case;
      
      EbeneSchleife:
      for EbeneSchleifenwert in Verschmutzungshöhe.EbeneAnfang .. Verschmutzungshöhe.EbeneEnde loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in Verschmutzungsbereich.SenkrechteAnfang .. Verschmutzungsbereich.SenkrechteEnde loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in Verschmutzungsbereich.WaagerechteAnfang .. Verschmutzungsbereich.WaagerechteEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => (EbeneSchleifenwert, Koordinaten.Senkrechte, Koordinaten.Waagerechte),
                                                                                                         ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                         TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               case
                 Kartenwert.Ebene
               is
                  when KartenKonstanten.LeerEbene =>
                     null;
                     
                  when others =>
                     SchreibeWeltkarte.Feldeffekt (KoordinatenExtern => Kartenwert,
                                                   FeldeffektExtern  => KartenextraDatentypen.Verschmutzt_Enum);
               end case;

            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Vorhanden_Enum'Range loop
         
         if
           SpeziesSchleifenwert = EinheitSpeziesNummerExtern.Spezies
           or
             LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert) = SpeziesDatentypen.Leer_Spieler_Enum
         then
            null;
            
         else
            SchreibeDiplomatie.AktuelleSympathie (SpeziesEinsExtern   => EinheitSpeziesNummerExtern.Spezies,
                                                  SpeziesZweiExtern   => SpeziesSchleifenwert,
                                                  SympathieExtern     => DiplomatieDatentypen.MeinungsänderungFeldeffekte (KartenextraDatentypen.Verschmutzt_Enum, EinheitSpeziesNummerExtern.Spezies),
                                                  RechnenSetzenExtern => True);
         end if;
         
      end loop SpeziesSchleife;
      
   end VerschmutzendeWaffeEingesetzt;

end VerschmutzendeWaffeEingesetztLogik;
