with KartenKonstanten;
with KartengrundDatentypen;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;
with SchreibeWeltkarte;

with KartenkoordinatenberechnungssystemLogik;

package body BiologischeWaffeEingesetztLogik is

   procedure BiologischeWaffeEingesetzt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Krankheitsbereich := LeseEinheitenDatenbank.Effektreichweite (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                    IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      Koordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in Krankheitsbereich.EAchseAnfang .. Krankheitsbereich.EAchseEnde loop
         YAchseSchleife:
         for YAchseSchleifenwert in Krankheitsbereich.YAchseAnfang .. Krankheitsbereich.YAchseEnde loop
            XAchseSchleife:
            for XAchseSchleifenwert in Krankheitsbereich.XAchseAnfang .. Krankheitsbereich.XAchseEnde loop

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
                                               EffektExtern      => KartengrundDatentypen.Biologisch_Enum);
               end case;

            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end BiologischeWaffeEingesetzt;

end BiologischeWaffeEingesetztLogik;
