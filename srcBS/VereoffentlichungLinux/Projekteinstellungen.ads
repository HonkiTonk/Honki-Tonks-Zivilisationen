with SystemRecords;
with SystemDatentypen;

package Projekteinstellungen is
   pragma Preelaborate;

   Einstellungen : constant SystemRecords.DebugRecord := (
                                                  VolleInformation => False,
                                                  FehlerWarnung    => False,
                                                  Betriebssystem     => SystemDatentypen.Linux_Enum
                                                 );

end Projekteinstellungen;
