with TonRecords;

package EinstellungenTon is
   pragma Preelaborate;
   
   Toneinstellungen : TonRecords.ToneinstellungenRecord;

   procedure StandardeinstellungenLaden;

   ToneinstellungenStandard : constant TonRecords.ToneinstellungenRecord := (
                                                                             Soundlautstärke => 50.00,
                                                                             Musiklautstärke => 50.00
                                                                            );

end EinstellungenTon;
