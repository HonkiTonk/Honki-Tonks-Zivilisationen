with SystemRecords;

package Projekteinstellungen is
   pragma Preelaborate;

   Debug : constant SystemRecords.DebugRecord := (
                                                  VolleInformation => True,
                                                  FehlerWarnung    => True,
                                                  LinuxWindows     => True
                                                 );

end Projekteinstellungen;
