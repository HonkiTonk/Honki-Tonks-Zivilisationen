with TonDatentypen;
with TonRecords;

package Musiktask is
   pragma Preelaborate;
   
   Musikart : TonRecords.MusikartRecord := (
                                            AktuelleMusikart => TonDatentypen.Musik_Pause_Enum,
                                            NeueMusikart     => TonDatentypen.Musik_Pause_Enum
                                           );
   
end Musiktask;
