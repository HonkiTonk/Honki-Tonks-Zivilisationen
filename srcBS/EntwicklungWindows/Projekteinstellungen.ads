with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Debug : SystemRecords.DebugRecord := (
                                         VolleInformation => True,
                                         FehlerWarnung    => True,
                                         LinuxWindows     => False
                                        );

end Projekteinstellungen;
