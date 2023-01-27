with KartenKonstanten;
with KartengrundDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body VerschmutzendeWaffeEingesetztLogik is

   procedure VerschmutzendeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Verschmutzungsbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in Verschmutzungsbereich.EAchseAnfang .. Verschmutzungsbereich.EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in Verschmutzungsbereich.YAchseAnfang .. Verschmutzungsbereich.YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in Verschmutzungsbereich.XAchseAnfang .. Verschmutzungsbereich.XAchseEnde loop

               Kartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Koordinaten,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               case
                 Kartenwert.EAchse
               is
                  when KartenKonstanten.LeerEAchse =>
                     null;
                     
                  when others =>
                     SchreibeWeltkarte.Effekt (KoordinatenExtern => Kartenwert,
                                               EffektExtern      => KartengrundDatentypen.Verschmutzt_Enum);
               end case;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end VerschmutzendeWaffeEingesetzt;

end VerschmutzendeWaffeEingesetztLogik;
