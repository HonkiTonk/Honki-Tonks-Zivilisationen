with TonRecords;

package EinstellungenMusik is
   pragma Preelaborate;

   Lautstärke : Float := 50.00;

   Musikeinstellungen : TonRecords.MusikeinstellungenRecord;

   procedure StandardeinstellungenLaden;

private

   Standardlautstärke : constant Float := 50.00;

   MusikeinstellungenStandard : constant TonRecords.MusikeinstellungenRecord := (
                                                                                 Lautstärke => 50.00
                                                                                );

end EinstellungenMusik;
