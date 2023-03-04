with TonRecords;

package EinstellungenMusik is
   pragma Preelaborate;

   Musikeinstellungen : TonRecords.MusikeinstellungenRecord;

   procedure StandardeinstellungenLaden;

private

   MusikeinstellungenStandard : constant TonRecords.MusikeinstellungenRecord := (
                                                                                 Lautstärke => 50.00
                                                                                );

end EinstellungenMusik;
